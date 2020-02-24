unit frame.DXV.LidarView;

interface

uses
  frame.master,
  system.diagnostics,
  dmCommon,
  neato.DXV.GetLDSScan,
  neato.helpers, FMX.TabControl,
  system.SysUtils, system.Types, system.UITypes, system.Classes, system.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, system.Math.Vectors, FMX.Types3D,
  FMX.Controls3D, FMX.Objects3D, FMX.Viewport3D, FMX.MaterialSources, FMX.Controls.Presentation, FMX.Layers3D,
  system.Rtti, FMX.Grid.Style, FMX.Grid, FMX.ScrollBox, FMX.Objects, FMX.Ani, FMX.Edit, FMX.EditBox, FMX.SpinBox,
  FMXTee.Engine,
  FMXTee.Series,
  FMXTee.Series.Polar,
  FMXTee.Tools,
  FMXTee.Functions.Stats,
  FMXTee.Procs,
  FMXTee.Chart, FMX.Layouts;

type
  TPlotPoint = Record
    Degree: Integer;
    X, Y: Double;
    Point: trectangle;
    Error: Double;
    intensity: cardinal;
    DistInMM: Double;
  end;

  TframeDXVLidarView = class(TframeMaster)
    tabsLidarViewOptions: TTabControl;
    tabLidarPlotXY: TTabItem;
    plotLidar: TChart;
    seriesPlotterXY: TPointSeries;
    tablidarpolar: TTabItem;
    Rectangle2: trectangle;
    Circle1: TCircle;
    polarLidar: TChart;
    seriesPolar: TPolarBarSeries;
    tabLidarCalculations: TTabItem;
    sgLIDAR: TStringGrid;
    StringColumn1: TStringColumn;
    StringColumn2: TStringColumn;
    StringColumn3: TStringColumn;
    StringColumn4: TStringColumn;
    StringColumn5: TStringColumn;
    StringColumn6: TStringColumn;
    StringColumn7: TStringColumn;
    StringColumn8: TStringColumn;
    StringColumn9: TStringColumn;
    StringColumn10: TStringColumn;
    rectPlotPoints: trectangle;
    pnlLidarLeft: trectangle;
    sbResetLIDARMapping: TSpinBox;
    lblResetLIDARmapping: TLabel;
    lblLidarDegree: TLabel;
    lblLidarDegreeValue: TLabel;
    lblLidarDistancemm: TLabel;
    lblLidarDistancemmValue: TLabel;
    lblLidarErrorCode: TLabel;
    lblLidarErrorCodeValue: TLabel;
    lblLidarIntesnity: TLabel;
    lblLidarIntesnityValue: TLabel;
    lblLidarSpeed: TLabel;
    lblLidarSpeedValue: TLabel;
    ckAutoScaleGraphs: TCheckBox;
    lblMaxDistance: TLabel;
    sbMaxDistance: TSpinBox;
    lblFPS: TLabel;
    lblDroppedPackets: TLabel;
    lblTotalFrames: TLabel;
    procedure Timer_GetDataTimer(Sender: TObject);

    procedure sgGetLDSScanDrawColumnCell(Sender: TObject; const Canvas: TCanvas; const Column: TColumn;
      const Bounds: TRectF; const Row: Integer; const Value: TValue; const State: TGridDrawStates);
    function seriesPlotterXYGetPointerStyle(Sender: TChartSeries; ValueIndex: Integer): TSeriesPointerStyle;
    function seriesPolarGetPointerStyle(Sender: TChartSeries; ValueIndex: Integer): TSeriesPointerStyle;
    procedure ckAutoScaleGraphsChange(Sender: TObject);
    procedure sbMaxDistanceChange(Sender: TObject);
    procedure sbResetLIDARMappingChange(Sender: TObject);
  private
    PlotPoints: array [0 .. 359] of TPlotPoint;

    fLIDARCounter: single;
    fActivePoint: trectangle;
    fMaxDistance: Integer;
    fFPS: TStopWatch;
    fFPSCount: Longint;
    fFPSDroppedPacketCount: Longint;
    fTotalFrames: Longint;
    fGoodPointSize: byte;
    fBadPointSize: byte;
    procedure rectPlotPointsMouseEnter(Sender: TObject);
    procedure rectPlotPointsMouseLeave(Sender: TObject);
    procedure SetGoodPointSize(Value: byte);
    procedure SetBadPointSize(Value: byte);
  public
    procedure check;
    constructor Create(AOwner: TComponent; Rect: trectangle); reintroduce; overload;
    destructor destroy; reintroduce; overload;
    property GoodPointSize: byte read fGoodPointSize write SetGoodPointSize;
    property BadPointSize: byte read fBadPointSize write SetBadPointSize;
  end;

implementation

{$R *.fmx}

constructor TframeDXVLidarView.Create(AOwner: TComponent; Rect: trectangle);
var
  idx: Integer;
begin
  inherited Create(AOwner, Rect);
  fFPS := TStopWatch.Create;

  fMaxDistance := 8000; // 8000mm
  fActivePoint := nil;
  tabsLidarViewOptions.TabIndex := 0;
  tabsLidarViewOptions.OnChange := dmCommon.onTabChangeEvent;
  fLIDARCounter := 0;
  fFPSCount := 0;
  fFPSDroppedPacketCount := 0;
  fTotalFrames := 0;

  lblFrameTitle.Text := sDescription;
  for idx := 0 to 359 do
  begin
    PlotPoints[idx].Point := trectangle.Create(rectPlotPoints);
    // PlotPoints[idx].Point.Parent := rectPlotPoints;

    if idx > 0 then
    begin
      PlotPoints[idx].Point.Position.X := PlotPoints[idx - 1].Point.Position.X + 5;
      PlotPoints[idx].Point.Position.Y := PlotPoints[idx - 1].Point.Position.Y;
    end;

    self.PlotPoints[idx].Point.Align := talignlayout.Left;
    PlotPoints[idx].Point.Width := rectPlotPoints.Width / 360;
    PlotPoints[idx].Point.Sides := [];
    PlotPoints[idx].Point.Fill.Color := talphacolorrec.Silver;
    PlotPoints[idx].Point.Tag := idx;
    PlotPoints[idx].Point.OnMouseEnter := self.rectPlotPointsMouseEnter;
    PlotPoints[idx].Point.OnMouseLeave := self.rectPlotPointsMouseLeave;

    PlotPoints[idx].Degree := idx;
    PlotPoints[idx].X := 0;
    PlotPoints[idx].Y := 0;
    PlotPoints[idx].Error := 0;
    PlotPoints[idx].intensity := 0;
  end;

  rectPlotPoints.BeginUpdate;
  for idx := 0 to 359 do
    PlotPoints[idx].Point.Parent := rectPlotPoints;
  rectPlotPoints.EndUpdate;

  sgLIDAR.RowCount := 360;

  self.ckAutoScaleGraphs.IsChecked := true;

  BadPointSize := 4;
  GoodPointSize := 4;

{$IFDEF ANDROID}
  BadPointSize := BadPointSize +1;  // make just a tad bigger
  GoodPointSize := GoodPointSize +1;
{$ENDIF}
end;

destructor TframeDXVLidarView.destroy;
begin
  inherited;
end;

procedure TframeDXVLidarView.ckAutoScaleGraphsChange(Sender: TObject);
begin
  inherited;

  plotLidar.Axes.Left.Automatic := ckAutoScaleGraphs.IsChecked;
  plotLidar.Axes.Bottom.Automatic := ckAutoScaleGraphs.IsChecked;

  polarLidar.Axes.top.Automatic := ckAutoScaleGraphs.IsChecked;
  polarLidar.Axes.Bottom.Automatic := ckAutoScaleGraphs.IsChecked;
  polarLidar.Axes.Left.Automatic := ckAutoScaleGraphs.IsChecked;
  polarLidar.Axes.right.Automatic := ckAutoScaleGraphs.IsChecked;

  resetfocus;
end;

procedure TframeDXVLidarView.check;
begin

  if dm.isComSerial then
    timer_getdata.Interval := 150
  else
    timer_getdata.Interval := 350;

  dm.chkTestmode.IsChecked := true;
  sleep(250);
  dm.com.SendCommand('Setldsrotation on');
  sleep(250);

  fFPSCount := 0;
  fLIDARCounter := 0;
  fFPSDroppedPacketCount := 0;
  fTotalFrames := 0;
  fFPS.Reset;
  fFPS.Start;
end;

procedure TframeDXVLidarView.rectPlotPointsMouseEnter(Sender: TObject);
var
  t: trectangle;
begin

  if not(Sender is trectangle) then
    exit;

  t := Sender as trectangle;

  fActivePoint := t;

  if (t.Tag >= 0) and (t.Tag <= 359) then
  begin
    lblLidarDegreeValue.Text := t.Tag.ToString;
    lblLidarDistancemmValue.Text := PlotPoints[t.Tag].DistInMM.ToString;
    lblLidarIntesnityValue.Text := PlotPoints[t.Tag].intensity.ToString;
    lblLidarErrorCodeValue.Text := PlotPoints[t.Tag].Error.ToString;
  end
  else
  begin
    lblLidarDegreeValue.Text := '-1';
    lblLidarDistancemmValue.Text := '-1';
    lblLidarIntesnityValue.Text := '-1';
    lblLidarErrorCodeValue.Text := '-1';
  end;
end;

procedure TframeDXVLidarView.rectPlotPointsMouseLeave(Sender: TObject);
begin
  fActivePoint := nil;
  lblLidarDegreeValue.Text := '-1';
  lblLidarDistancemmValue.Text := '-1';
  lblLidarIntesnityValue.Text := '-1';
  lblLidarErrorCodeValue.Text := '-1';
end;

procedure TframeDXVLidarView.sbMaxDistanceChange(Sender: TObject);
begin
  inherited;
  fMaxDistance := round(sbMaxDistance.Value);
  self.plotLidar.Axes.Left.Maximum := sbMaxDistance.Value;
  self.plotLidar.Axes.Left.Minimum := -abs(sbMaxDistance.Value);
  self.plotLidar.Axes.Bottom.Maximum := sbMaxDistance.Value;
  self.plotLidar.Axes.Bottom.Minimum := -abs(sbMaxDistance.Value);

  self.polarLidar.Axes.top.Maximum := sbMaxDistance.Value;
  self.polarLidar.Axes.top.Minimum := -abs(sbMaxDistance.Value);
  self.polarLidar.Axes.Bottom.Maximum := sbMaxDistance.Value;
  self.polarLidar.Axes.Bottom.Minimum := -abs(sbMaxDistance.Value);
  self.polarLidar.Axes.Left.Maximum := sbMaxDistance.Value;
  self.polarLidar.Axes.Left.Minimum := -abs(sbMaxDistance.Value);
  self.polarLidar.Axes.right.Maximum := sbMaxDistance.Value;
  self.polarLidar.Axes.right.Minimum := -abs(sbMaxDistance.Value);
  self.ckAutoScaleGraphs.IsChecked := true;
  resetfocus;
end;

procedure TframeDXVLidarView.sbResetLIDARMappingChange(Sender: TObject);
begin
  inherited;
  resetfocus;
end;

procedure TframeDXVLidarView.SetGoodPointSize(Value: byte);
begin
  if Value = 0 then
    Value := 1;
  fGoodPointSize := Value;
end;

procedure TframeDXVLidarView.SetBadPointSize(Value: byte);
begin
  if Value = 0 then
    Value := 1;
  fBadPointSize := Value;
end;

function TframeDXVLidarView.seriesPlotterXYGetPointerStyle(Sender: TChartSeries; ValueIndex: Integer)
  : TSeriesPointerStyle;
begin
  inherited;
  if seriesPlotterXY.ValueColor[ValueIndex] = talphacolorrec.Red then
  begin
    seriesPlotterXY.Pointer.HorizSize := BadPointSize;
    seriesPlotterXY.Pointer.VertSize := BadPointSize;
    Result := TSeriesPointerStyle.psTriangle;
  end
  else
  begin
    seriesPlotterXY.Pointer.HorizSize := GoodPointSize;
    seriesPlotterXY.Pointer.VertSize := GoodPointSize;
    Result := TSeriesPointerStyle.psRectangle;
  end;
end;

function TframeDXVLidarView.seriesPolarGetPointerStyle(Sender: TChartSeries; ValueIndex: Integer): TSeriesPointerStyle;
begin
  inherited;
  if seriesPolar.XValue[ValueIndex] = 0 then
  begin
    seriesPolar.Pointer.HorizSize := BadPointSize;
    seriesPolar.Pointer.VertSize := BadPointSize;
    Result := TSeriesPointerStyle.psTriangle
  end
  else
  begin
    seriesPolar.Pointer.HorizSize := GoodPointSize;
    seriesPolar.Pointer.VertSize := GoodPointSize;
    Result := TSeriesPointerStyle.psRectangle;
  end;
end;

procedure TframeDXVLidarView.sgGetLDSScanDrawColumnCell(Sender: TObject; const Canvas: TCanvas; const Column: TColumn;
  const Bounds: TRectF; const Row: Integer; const Value: TValue; const State: TGridDrawStates);
var
  aRowColor: TBrush;
  aNewRectF: TRectF;
begin
  aRowColor := TBrush.Create(TBrushKind.Solid, TAlphaColors.Alpha);

  if (sgLIDAR.Cells[3, Row] <> '0') then
    aRowColor.Color := TAlphaColors.Red
  else
    aRowColor.Color := TAlphaColors.White;

  aNewRectF := Bounds;
  aNewRectF.Inflate(3, 3);
  Canvas.FillRect(aNewRectF, 0, 0, [], 1, aRowColor);
  Column.DefaultDrawCell(Canvas, Bounds, Row, Value, State);

  aRowColor.free;
end;

procedure TframeDXVLidarView.Timer_GetDataTimer(Sender: TObject);
var
  pGetLDSScan: tGetLDSScanDXV;
  pReadData: TStringList;
  R: Boolean;

  function ChangeBrightness(const AColor: TAlphaColor; const AScale: Double): TAlphaColor;
  var
    LRec: talphacolorrec;
  begin
    LRec := talphacolorrec(AColor);
    LRec.R := round(LRec.R * (AScale / 100));
    LRec.G := round(LRec.G * (AScale / 100));
    LRec.B := round(LRec.B * (AScale / 100));
    Result := TAlphaColor(LRec);
  end;

  procedure MapLIDAR;

  Const
    D2R = 0.017453293;
    // PI divided by 180 degrees, multiply by this to get angle in degrees expressed in radians
    betaDegree = 82;
    // (degree) angle (for geometric correction) between laser beam and line parallel to the image plane
    bmm = 25; // (mm) distance (for geometric correction) between the rotation center and laser source along line parallel to the image plane

    Function CalcXCorrection(fiDegree, Distance: Double): Double;
    // Calculate x - add this to geometric correction to get object coordinates
    begin
      Result := -SIN(fiDegree * D2R) * Distance;
    end;

    Function CalcYCorrection(Degree, Distance: Double): Double;
    // Calculate y - add this to geometric correction to get object coordinates
    begin
      Result := Cos(Degree * D2R) * Distance;
    end;

    function CalcAlfaX(fiDegree: Double): Double;
    // Calculate x geometric correction - add this to x' and y' to get object coordinates
    var
      alfa: Double;
    begin
      alfa := 180 - betaDegree + fiDegree;
      Result := bmm * SIN(alfa * D2R);
    end;

    function CalcAlfaY(fiDegree: Double): Double;
    // Calculate y geometric correction - add this to x' and y' to get object coordinates
    var
      alfa: Double;
    begin
      alfa := 180 - betaDegree + fiDegree;
      Result := -bmm * Cos(alfa * D2R);
    end;

    function CalcFinalX(X1: Double; X2: Double): Double; // Calculate x - object coordinates
    begin
      Result := X1 + X2;
    end;

    function CalcFinalY(Y1: Double; Y2: Double): Double; // Calculate y - object coordinates
    begin
      Result := Y1 + Y2;
    end;

  var

    RowIDX: Integer; // loop variable

    AngleInDegrees: Double;
    DistInMM: Double;
    intensity: cardinal;
    errorcode: Integer;

    originalX: Double; // X original calc
    originalY: Double; // Y original calc

    calculatedX: Double; // X 2nd calc (alfa?)
    calculatedY: Double; // Y 2nd calc (alfa?)

    finalX: Double; // X 3rd final calc
    finalY: Double; // Y 3rd final calc

    IntensityColor: cardinal;

  begin

    // need to clean this up, but doing tests to try and improve the LiDAR FPS
    // we can only view one tab at a time here so try and only do work
    // for the tab you are on!

    if tabsLidarViewOptions.ActiveTab = self.tabLidarPlotXY then
      seriesPlotterXY.BeginUpdate
    else if tabsLidarViewOptions.ActiveTab = self.tablidarpolar then
      self.seriesPolar.BeginUpdate
    else if tabsLidarViewOptions.ActiveTab = self.tabLidarCalculations then
      sgLIDAR.BeginUpdate;

    if sbResetLIDARMapping.Value > 0 then
    begin
      if round(fLIDARCounter) >= round(sbResetLIDARMapping.Value) then
      begin
        if tabsLidarViewOptions.ActiveTab = self.tabLidarPlotXY then
          seriesPlotterXY.Clear
        else if tabsLidarViewOptions.ActiveTab = self.tablidarpolar then
          seriesPolar.Clear;
        fLIDARCounter := 0;
      end;
    end;


    // change this so the object collection is used.
    // don't use the grid for anything other than visual representation of the data!

    for RowIDX := 0 to 359 do // sgLIDAR.RowCount - 1 do
    begin

      if tabsLidarViewOptions.ActiveTab = self.tabLidarCalculations then
      begin
        sgLIDAR.Cells[0, RowIDX] := pGetLDSScan.GetLDSScanRecords[RowIDX + 1].AngleInDegrees.ToString;
        sgLIDAR.Cells[1, RowIDX] := pGetLDSScan.GetLDSScanRecords[RowIDX + 1].DistInMM.ToString;
        sgLIDAR.Cells[2, RowIDX] := pGetLDSScan.GetLDSScanRecords[RowIDX + 1].intensity.ToString;
        sgLIDAR.Cells[3, RowIDX] := pGetLDSScan.GetLDSScanRecords[RowIDX + 1].ErrorCodeHEX.ToString;
      end;

      AngleInDegrees := pGetLDSScan.GetLDSScanRecords[RowIDX + 1].AngleInDegrees;
      DistInMM := pGetLDSScan.GetLDSScanRecords[RowIDX + 1].DistInMM;
      intensity := pGetLDSScan.GetLDSScanRecords[RowIDX + 1].intensity;
      errorcode := pGetLDSScan.GetLDSScanRecords[RowIDX + 1].ErrorCodeHEX;

      // if errorcode <> 0 then   continue;

      // Calculate x' and y' - add this to geometric correction to get object coordinates
      originalX := CalcXCorrection(AngleInDegrees, DistInMM);
      originalY := CalcYCorrection(AngleInDegrees, DistInMM);

      if tabsLidarViewOptions.ActiveTab = self.tabLidarCalculations then
      begin
        sgLIDAR.Cells[4, RowIDX] := originalX.ToString;
        sgLIDAR.Cells[5, RowIDX] := originalY.ToString;
      end;

      // Calculate x and y geometric correction - add this to x' and y' to get object coordinates
      calculatedX := CalcAlfaX(AngleInDegrees);
      calculatedY := CalcAlfaY(AngleInDegrees);

      if tabsLidarViewOptions.ActiveTab = self.tabLidarCalculations then
      begin
        sgLIDAR.Cells[6, RowIDX] := calculatedX.ToString;
        sgLIDAR.Cells[7, RowIDX] := calculatedY.ToString;
      end;

      // Calculate x and y - object coordinates

      finalX := CalcFinalX(originalX, calculatedX);
      finalY := CalcFinalY(originalY, calculatedY);

      if tabsLidarViewOptions.ActiveTab = self.tabLidarCalculations then
      begin
        sgLIDAR.Cells[8, RowIDX] := finalX.ToString;
        sgLIDAR.Cells[9, RowIDX] := finalY.ToString;
      end;

      if (finalY < fMaxDistance) and (finalY > -abs(fMaxDistance)) and (finalX < fMaxDistance) and
        (finalX > -abs(fMaxDistance)) then
      begin

        if errorcode > 0 then
        begin
          IntensityColor := talphacolorrec.Red;
          if tabsLidarViewOptions.ActiveTab = self.tabLidarPlotXY then
            seriesPlotterXY.AddXY(finalX, finalY, '', talphacolorrec.Red)
          else if tabsLidarViewOptions.ActiveTab = self.tablidarpolar then
            seriesPolar.AddPolar(RowIDX, DistInMM, '', talphacolorrec.Red);
        end
        else
        begin
          IntensityColor := ChangeBrightness(talphacolorrec.green, map(intensity, 0, 1024, 50, 150));

          if tabsLidarViewOptions.ActiveTab = self.tabLidarPlotXY then
            seriesPlotterXY.AddXY(finalX, finalY, '', IntensityColor)
          else if tabsLidarViewOptions.ActiveTab = self.tablidarpolar then
          begin
            seriesPolar.Pen.Color := IntensityColor;
            seriesPolar.AddPolar(RowIDX, DistInMM, '', IntensityColor);
          end;
        end;

        PlotPoints[RowIDX].X := finalX;
        PlotPoints[RowIDX].Y := finalY;
        PlotPoints[RowIDX].Degree := RowIDX;
        PlotPoints[RowIDX].Error := errorcode;
        PlotPoints[RowIDX].intensity := intensity;
        PlotPoints[RowIDX].DistInMM := DistInMM;

        if assigned(fActivePoint) then
          rectPlotPointsMouseEnter(fActivePoint);

        if PlotPoints[RowIDX].Point.Fill.Color <> IntensityColor then
          PlotPoints[RowIDX].Point.Fill.Color := IntensityColor;

      end;
    end;

    if tabsLidarViewOptions.ActiveTab = self.tabLidarPlotXY then
      seriesPlotterXY.EndUpdate
    else if tabsLidarViewOptions.ActiveTab = self.tablidarpolar then
      self.seriesPolar.EndUpdate
    else if tabsLidarViewOptions.ActiveTab = self.tabLidarCalculations then
      sgLIDAR.EndUpdate;

  end;

begin

  if (dm.com.Active = false) or (dm.ActiveTab <> Tab) then
  begin
    timer_getdata.Enabled := false;
    exit;
  end;

  pGetLDSScan := tGetLDSScanDXV.Create;

  pReadData := TStringList.Create;
  pReadData.Text := dm.com.SendCommand(sGetLDSScan);

  R := pGetLDSScan.ParseText(pReadData);

  pnlLidarLeft.BeginUpdate;

  inc(fTotalFrames);
  lblTotalFrames.Text := fTotalFrames.ToString;

  if R then
  begin
    inc(fFPSCount);
    lblFPS.Text := floattostrf(fFPSCount / (fFPS.ElapsedMilliseconds / 1000), fffixed, 4, 2) + 'fps';
    fLIDARCounter := fLIDARCounter + 1;
    lblLidarSpeedValue.Text := pGetLDSScan.Rotation_Speed.ToString;
    MapLIDAR;
  end
  else
  begin
    inc(fFPSDroppedPacketCount);
    lblDroppedPackets.Text := fFPSDroppedPacketCount.ToString;
  end;

  pnlLidarLeft.EndUpdate;

  pReadData.free;
  pGetLDSScan.free;
end;

end.
