unit View.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.ImageList,
  Vcl.ImgList, Vcl.Buttons, Vcl.StdCtrls, Vcl.ComCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, model.conexao, System.Actions, Vcl.ActnList,
  Vcl.CategoryButtons, Vcl.WinXCtrls,Datasnap.DBClient,System.StrUtils;

type
  TFrmPrincipal = class(TForm)
    pnl_top: TPanel;
    btn_fechar: TSpeedButton;
    btn_minimizar: TSpeedButton;
    ImageList: TImageList;
    DataSource: TDataSource;
    ImageList1: TImageList;
    pnl_main: TPanel;
    DBGrid1: TDBGrid;
    pnl_linha: TPanel;
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    ScrollBox1: TScrollBox;
    Memo1: TMemo;
    Panel2: TPanel;
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SplitView1: TSplitView;
    Panel3: TPanel;
    ActionList1: TActionList;
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    Action4: TAction;
    Action5: TAction;
    btn_entidades: TSpeedButton;
    Action6: TAction;
    scrol_tables: TScrollBox;
    ListBox1: TListBox;
    scrol_field: TScrollBox;
    pnl_fields: TPanel;
    ListBox2: TListBox;
    Panel4: TPanel;
    OpenDialog1: TOpenDialog;
    SpeedButton3: TSpeedButton;
    Panel5: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure pnl_topMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_minimizarClick(Sender: TObject);
    procedure btn_fecharClick(Sender: TObject);
    procedure btn_minimizarMouseLeave(Sender: TObject);
    procedure btn_minimizarMouseEnter(Sender: TObject);
    procedure btn_fecharMouseLeave(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);

    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure btn_entidadesClick(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation
uses FireDAC.Comp.Client,System.RegularExpressions, System.SysUtils;
const ReservedWords: array[0..317] of string = ('[ABS]' ,'ACTION' ,'ACTIVE' ,'ADD' ,'ADMIN' ,'AFTER' ,'ALL' ,'ALTER' ,'AND' ,'ANY' ,'ARE' ,'AS' ,'ASC' ,'ASCENDING' ,'AT' ,'AUTO' ,'AUTODDL' ,'AVG' ,'BASED' ,'BASENAME' ,'BASE_NAME' ,'BEFORE' ,'BEGIN' ,'BETWEEN' ,'BIGINT' ,'BLOB' ,'BLOBEDIT' ,'[BOOLEAN]' ,'[BOTH]' ,'/* BREAK */' ,'BUFFER' ,'BY' ,'CACHE' ,'CASCADE' ,'CASE' ,'CAST' ,'CHAR' ,'CHARACTER' ,'[CHAR_LENGTH]' ,'[CHARACTER_LENGTH]' ,'CHECK' ,'CHECK_POINT_LEN' ,'CHECK_POINT_LENGTH' ,'CLOSE' ,'COALESCE' ,'COLLATE' ,'COLLATION' ,'COLUMN' ,'COMMIT' ,'COMMITTED' ,'COMPILETIME' ,'COMPUTED' ,'CONDITIONAL' ,'CONNECT' ,'CONSTRAINT' ,'CONTAINING' ,'CONTINUE' ,'COUNT' ,'CREATE' ,'CSTRING' ,'CURRENT' ,'CURRENT_CONNECTION' ,'CURRENT_DATE' ,'CURRENT_ROLE' ,'CURRENT_TIME' ,'CURRENT_TIMESTAMP' ,'CURRENT_TRANSACTION' ,'CURRENT_USER' ,'DATABASE' ,'DATE' ,'DAY' ,'DB_KEY' ,'DEBUG' ,'DEC' ,'DECIMAL' ,'DECLARE' ,'DEFAULT' ,'[DEFERRED]' ,'DELETE',
                                                'DELETING' ,'DESC' ,'DESCENDING' ,'DESCRIBE' ,'/* DESCRIPTOR */' ,'DISCONNECT' ,'DISPLAY' ,'DISTINCT' ,'DO' ,'DOMAIN' ,'DOUBLE' ,'DROP' ,'ECHO' ,'EDIT' ,'ELSE' ,'END' ,'ENTRY_POINT' ,'ESCAPE' ,'EVENT' ,'EXCEPTION' ,'EXECUTE' ,'EXISTS' ,'EXIT' ,'EXTERN' ,'EXTERNAL' ,'EXTRACT' ,'[FALSE]' ,'FETCH' ,'FILE' ,'FILTER' ,'/* FIRST */' ,'FLOAT' ,'FOR' ,'FOREIGN' ,'FOUND' ,'FREE_IT' ,'FROM' ,'FULL' ,'FUNCTION' ,'GDSCODE' ,'GENERATOR' ,'GEN_ID' ,'[GLOBAL]' ,'GOTO' ,'GRANT' ,'GROUP' ,'GROUP_COMMIT_WAIT' ,'GROUP_COMMIT_WAIT_TIME' ,'HAVING' ,'HEADING' ,'HELP' ,'HOUR' ,'IF' ,'/* IIF */' ,'IMMEDIATE' ,'IN' ,'INACTIVE' ,'INDEX' ,'INDICATOR' ,'INIT' ,'INNER' ,'INPUT' ,'INPUT_TYPE' ,'INSERT' ,'INSERTING' ,'INT' ,'INTEGER' ,'INTO' ,'IS' ,'ISOLATION' ,'ISQL' ,'JOIN' ,'KEY' ,'LAST' ,'LC_MESSAGES' ,'LC_TYPE' ,'[LEADING]' ,'LEAVE' ,'LEFT' ,'LENGTH' ,'LEV' ,'LEVEL' ,'LIKE' ,'LOCK' ,'LOGFILE' ,'LOG_BUFFER_SIZE' ,
                                                'LOG_BUF_SIZE' ,'LONG' ,'MANUAL' ,'MAX' ,'MAXIMUM' ,'MAXIMUM_SEGMENT' ,'MAX_SEGMENT' ,'MERGE' ,'MESSAGE' ,'MIN' ,'MINIMUM' ,'MINUTE' ,'MODULE_NAME' ,'MONTH' ,'NAMES' ,'NATIONAL' ,'NATURAL' ,'NCHAR' ,'NO' ,'NOAUTO' ,'NOT' ,'NULL' ,'NULLIF' ,'NULLS' ,'NUM_LOG_BUFS' ,'NUM_LOG_BUFFERS' ,'NUMERIC' ,'[OCTET_LENGTH]' ,'OF' ,'ON' ,'ONLY' ,'OPEN' ,'OPTION' ,'OR' ,'ORDER' ,'OUTER' ,'OUTPUT' ,'OUTPUT_TYPE' ,'OVERFLOW' ,'PAGE' ,'PAGELENGTH' ,'PAGES' ,'PAGE_SIZE' ,'PARAMETER' ,'PASSWORD' ,'[PERCENT]' ,'PLAN' ,'POSITION' ,'POST_EVENT' ,'PRECISION' ,'PREPARE' ,'[PRESERVE]' ,'PRIMARY' ,'PRIVILEGES' ,'PROCEDURE' ,'PUBLIC' ,'QUIT' ,'RAW_PARTITIONS' ,'RDB$DB_KEY' ,'READ' ,'REAL' ,'RECORD_VERSION' ,'RECREATE' ,'REFERENCES' ,'RELEASE' ,'RESERV' ,'RESERVING' ,'RESTRICT' ,'RETAIN' ,'RETURN' ,'RETURNING_VALUES' ,'RETURNS' ,'REVOKE' ,'RIGHT' ,'ROLE' ,'ROLLBACK' ,'ROW_COUNT' ,'[ROWS]' ,'RUNTIME' ,'SAVEPOINT' ,
                                                'SCHEMA' ,'SECOND' ,'SELECT' ,'SET' ,'SHADOW' ,'SHARED' ,'SHELL' ,'SHOW' ,'SINGULAR' ,'SIZE' ,'/* SKIP */' ,'SMALLINT' ,'SNAPSHOT' ,'SOME' ,'SORT' ,'SQL' ,'SQLCODE' ,'SQLERROR' ,'SQLWARNING' ,'STABILITY' ,'STARTING' ,'STARTS' ,'STATEMENT' ,'STATIC' ,'STATISTICS' ,'SUB_TYPE' ,'/* SUBSTRING */' ,'SUM' ,'SUSPEND' ,'TABLE' ,'[TEMPORARY]' ,'TERM' ,'TERMINATOR' ,'THEN' ,'[TIES]' ,'TIME' ,'TIMESTAMP' ,'TO' ,'[TRAILING]' ,'TRANSACTION' ,'TRANSLATE' ,'TRANSLATION' ,'TRIGGER' ,'[TRIM]' ,'[TRUE]' ,'TYPE' ,'UNCOMMITTED' ,'UNION' ,'UNIQUE' ,'[UNKNOWN]' ,'UPDATE' ,'UPDATING' ,'UPPER' ,'USER' ,'USING' ,'VALUE' ,'VALUES' ,'VARCHAR' ,'VARIABLE' ,'VARYING' ,'VERSION' ,'VIEW' ,'WAIT' ,'WEEKDAY' ,'WHEN' ,'WHENEVER' ,'WHERE' ,'WHILE' ,'WITH' ,'WORK' ,'WRITE' ,'YEAR' ,'YEARDAY');


{$R *.dfm}

procedure TFrmPrincipal.btn_fecharClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmPrincipal.btn_fecharMouseLeave(Sender: TObject);
begin
  btn_fechar.IsLightStyleColor(clred);
end;

procedure TFrmPrincipal.btn_minimizarClick(Sender: TObject);
begin
  Application.Minimize;
end;

procedure TFrmPrincipal.btn_minimizarMouseEnter(Sender: TObject);
begin
  screen.Cursor := crHandPoint;
end;

procedure TFrmPrincipal.btn_minimizarMouseLeave(Sender: TObject);
begin
  screen.Cursor := crDefault;
end;

procedure TFrmPrincipal.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
VAR
  RowIndex: Integer;
  palavra: string;

begin
   if (DMConexao.DataSet.FindField('ATIVO')<> NIL) and
      (DMConexao.DataSet.FindField('ATIVO').AsString='F') then
      DBGrid1.Canvas.Font.Color := clred;

   if (DMConexao.DataSet.FindField('STATUS')<> NIL) and
      ((DMConexao.DataSet.FindField('STATUS').AsString='C') or
      (DMConexao.DataSet.FindField('STATUS').AsString='D')) then
      DBGrid1.Canvas.Font.Color := clred;

  TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
  DataSource.DataSet := DMConexao.DataSet;
end;

procedure TFrmPrincipal.ListBox1Click(Sender: TObject);
begin
 DMConexao.FDConnection.GetFieldNames('',
                                      '',
                                      ListBox1.Items[ListBox1.ItemIndex],
                                      '',
                                      ListBox2.Items);

 Memo1.Lines.Clear;
 Memo1.Lines.Add('select * from ' +  ListBox1.Items[ListBox1.ItemIndex])

end;

procedure TFrmPrincipal.Memo1Change(Sender: TObject);
var
  Regex: TRegEx;
  Match: TMatch;
begin

end;


procedure TFrmPrincipal.pnl_topMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  screen.Cursor := crSizeAll;
  ReleaseCapture;
  Self.Perform(wm_nclbuttondown, HTCAPTION, 0);
  screen.Cursor := crDefault;
end;

procedure TFrmPrincipal.SpeedButton1Click(Sender: TObject);
begin
   SplitView1.Visible := not SplitView1.Visible;
end;

procedure TFrmPrincipal.SpeedButton2Click(Sender: TObject);
begin
  DMConexao.SQL(Memo1.Text);
  StatusBar1.Panels[1].Text := InttoStr(DMConexao.DataSet.RecordCount);

  if DBGrid1.DataSource.DataSet.recordcount=0 then
    begin
     StatusBar1.Panels[1].Text:='Sem resultado';
     StatusBar1.Font.Color :=clRed;
    end;


end;

procedure TFrmPrincipal.SpeedButton3Click(Sender: TObject);
begin
if OpenDialog1.Execute then
  begin
    Memo1.Lines.LoadFromFile(OpenDialog1.FileName);
  end;
end;

procedure TFrmPrincipal.btn_entidadesClick(Sender: TObject);
var
  avalue: integer;
begin
   scrol_tables.Visible  := not scrol_tables.Visible;
   scrol_field.Visible   := not scrol_field.Visible;
   pnl_fields.Visible    := not pnl_fields.Visible;
   Panel4.Visible        := not Panel4.Visible;
   Label1.Visible        := not Label1.Visible;
   Label2.Visible        := not Label2.Visible;
 DMConexao.FDConnection.GetTableNames('',
                                      '',
                                      '',
                                      ListBox1.Items);

 DMConexao.SQL(' SELECT MON$PAGE_SIZE,MON$DATABASE_NAME ' +
               ' FROM MON$DATABASE');
   DMConexao.FDQuery.Open;

  if not (DMConexao.FDQuery.FieldByName('MON$PAGE_SIZE').IsNull) then
   Label1.Caption:='Page Size: ' + IntToStr(DMConexao
                                                 .FDQuery
                                              .FieldByName('MON$PAGE_SIZE').AsInteger) ;
   Label2.Caption:='Caminho:'+ DMConexao
                                     .FDQuery
                                  .FieldByName('MON$DATABASE_NAME').AsString;
  /// Label3.Caption   := 'Tamanho DB:' + IntToStr((DMConexao.GetFileSize(DMConexao.FDConnection.Params.Database)));
   DMConexao.FDQuery.Close;



end;

end.
