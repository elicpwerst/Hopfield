object HopfieldForm: THopfieldForm
  Left = 0
  Top = 0
  Caption = 'Hopfield application'
  ClientHeight = 348
  ClientWidth = 547
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object TitleLbl: TAdvSmoothLabel
    Left = 123
    Top = 8
    Width = 280
    Height = 50
    Fill.ColorMirror = clNone
    Fill.ColorMirrorTo = clNone
    Fill.GradientType = gtVertical
    Fill.GradientMirrorType = gtSolid
    Fill.BorderColor = clNone
    Fill.Rounding = 0
    Fill.ShadowOffset = 0
    Fill.Glow = gmNone
    Caption.Text = 'AdvSmoothLabel'
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clWindowText
    Caption.Font.Height = -27
    Caption.Font.Name = 'Tahoma'
    Caption.Font.Style = []
    Caption.ColorStart = clBlue
    Caption.ColorEnd = 16777088
    CaptionShadow.Text = 'AdvSmoothLabel'
    CaptionShadow.Font.Charset = DEFAULT_CHARSET
    CaptionShadow.Font.Color = clWindowText
    CaptionShadow.Font.Height = -27
    CaptionShadow.Font.Name = 'Tahoma'
    CaptionShadow.Font.Style = []
    Version = '1.6.0.2'
  end
  object sheet: TAdvStringGrid
    Left = 34
    Top = 80
    Width = 452
    Height = 158
    Cursor = crDefault
    Color = clWhite
    ColCount = 7
    DrawingStyle = gdsClassic
    FixedCols = 0
    RowCount = 7
    FixedRows = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
    HoverRowCells = [hcNormal, hcSelected]
    OnClickCell = sheetClickCell
    ActiveCellFont.Charset = DEFAULT_CHARSET
    ActiveCellFont.Color = clWindowText
    ActiveCellFont.Height = -11
    ActiveCellFont.Name = 'Tahoma'
    ActiveCellFont.Style = [fsBold]
    BackGround.Color = clWhite
    ControlLook.FixedGradientHoverFrom = clGray
    ControlLook.FixedGradientHoverTo = clWhite
    ControlLook.FixedGradientDownFrom = clGray
    ControlLook.FixedGradientDownTo = clSilver
    ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
    ControlLook.DropDownHeader.Font.Color = clWindowText
    ControlLook.DropDownHeader.Font.Height = -11
    ControlLook.DropDownHeader.Font.Name = 'Tahoma'
    ControlLook.DropDownHeader.Font.Style = []
    ControlLook.DropDownHeader.Visible = True
    ControlLook.DropDownHeader.Buttons = <>
    ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
    ControlLook.DropDownFooter.Font.Color = clWindowText
    ControlLook.DropDownFooter.Font.Height = -11
    ControlLook.DropDownFooter.Font.Name = 'Tahoma'
    ControlLook.DropDownFooter.Font.Style = []
    ControlLook.DropDownFooter.Visible = True
    ControlLook.DropDownFooter.Buttons = <>
    Filter = <>
    FilterDropDown.Font.Charset = DEFAULT_CHARSET
    FilterDropDown.Font.Color = clWindowText
    FilterDropDown.Font.Height = -11
    FilterDropDown.Font.Name = 'Tahoma'
    FilterDropDown.Font.Style = []
    FilterDropDownClear = '(All)'
    FilterEdit.TypeNames.Strings = (
      'Starts with'
      'Ends with'
      'Contains'
      'Not contains'
      'Equal'
      'Not equal'
      'Clear')
    FixedRowHeight = 22
    FixedFont.Charset = DEFAULT_CHARSET
    FixedFont.Color = clWindowText
    FixedFont.Height = -11
    FixedFont.Name = 'Tahoma'
    FixedFont.Style = [fsBold]
    FloatFormat = '%.2f'
    HoverButtons.Buttons = <>
    HoverButtons.Position = hbLeftFromColumnLeft
    PrintSettings.DateFormat = 'dd/mm/yyyy'
    PrintSettings.Font.Charset = DEFAULT_CHARSET
    PrintSettings.Font.Color = clWindowText
    PrintSettings.Font.Height = -11
    PrintSettings.Font.Name = 'Tahoma'
    PrintSettings.Font.Style = []
    PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
    PrintSettings.FixedFont.Color = clWindowText
    PrintSettings.FixedFont.Height = -11
    PrintSettings.FixedFont.Name = 'Tahoma'
    PrintSettings.FixedFont.Style = []
    PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
    PrintSettings.HeaderFont.Color = clWindowText
    PrintSettings.HeaderFont.Height = -11
    PrintSettings.HeaderFont.Name = 'Tahoma'
    PrintSettings.HeaderFont.Style = []
    PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
    PrintSettings.FooterFont.Color = clWindowText
    PrintSettings.FooterFont.Height = -11
    PrintSettings.FooterFont.Name = 'Tahoma'
    PrintSettings.FooterFont.Style = []
    PrintSettings.PageNumSep = '/'
    SearchFooter.FindNextCaption = 'Find &next'
    SearchFooter.FindPrevCaption = 'Find &previous'
    SearchFooter.Font.Charset = DEFAULT_CHARSET
    SearchFooter.Font.Color = clWindowText
    SearchFooter.Font.Height = -11
    SearchFooter.Font.Name = 'Tahoma'
    SearchFooter.Font.Style = []
    SearchFooter.HighLightCaption = 'Highlight'
    SearchFooter.HintClose = 'Close'
    SearchFooter.HintFindNext = 'Find next occurrence'
    SearchFooter.HintFindPrev = 'Find previous occurrence'
    SearchFooter.HintHighlight = 'Highlight occurrences'
    SearchFooter.MatchCaseCaption = 'Match case'
    SelectionColor = clWhite
    ShowSelection = False
    SortSettings.DefaultFormat = ssAutomatic
    Version = '7.4.4.2'
  end
  object Shader: TShader
    Left = 0
    Top = 307
    Width = 547
    Height = 41
    Align = alBottom
    TabOrder = 1
    FromColor = 16777088
    ToColor = clWhite
    Direction = False
    Version = '1.4.1.0'
    ExplicitWidth = 519
    DesignSize = (
      547
      41)
    object TrainBtn: TButton
      Left = 34
      Top = 8
      Width = 75
      Height = 25
      Caption = 'TrainBtn'
      TabOrder = 0
      OnClick = TrainBtnClick
    end
    object matchBtn: TButton
      Left = 117
      Top = 8
      Width = 80
      Height = 25
      Caption = 'matchBtn'
      TabOrder = 1
      OnClick = matchBtnClick
    end
    object ClearBtn: TButton
      Left = 302
      Top = 8
      Width = 75
      Height = 25
      Hint = 'Clears the table above'
      Anchors = [akTop, akRight]
      Caption = 'ClearBtn'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = ClearBtnClick
    end
    object EraseBtn: TButton
      Left = 383
      Top = 8
      Width = 103
      Height = 25
      Hint = 'zeros out the weighted matrix'
      Anchors = [akTop, akRight]
      Caption = 'EraseBtn'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = EraseBtnClick
    end
  end
end
