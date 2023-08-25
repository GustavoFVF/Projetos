unit View.Configuracao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, View.Base, System.ImageList,
  Vcl.ImgList, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, model.interfaces, FireDAC.Comp.Client,
  model.conectors.firedac;

type
  TFrmConfiguracao = class(TFrmBase)
    Panel4: TPanel;
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    pnl_butons: TPanel;
    Panel5: TPanel;
    btn_gravar: TSpeedButton;
    Panel6: TPanel;
    btn_Cancelar: TSpeedButton;
    Panel2: TPanel;
    Label3: TLabel;
    Panel7: TPanel;
    Edt_Servidor: TLabeledEdit;
    Edt_Porta: TLabeledEdit;
    Edt_caminhoBanco: TLabeledEdit;
    edt_login: TLabeledEdit;
    edt_Senha: TLabeledEdit;
    Panel3: TPanel;
    Label4: TLabel;
    Panel8: TPanel;
    edt_caminho_Atual: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    procedure btn_gravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  FConn :TFDConnection;
  FConf: iConfiguracao;
  FConexao:TConnectionFiredad;
  public
    { Public declarations }
  end;

var
  FrmConfiguracao: TFrmConfiguracao;

implementation
uses
 Utils,Model.conectors.configuration;

{$R *.dfm}

procedure TFrmConfiguracao.btn_gravarClick(Sender: TObject);
begin
  inherited;
//  TUtil.ValidarCamposObrigatorio(FrmConfiguracao);
  FConn.Params.Database :=Edt_caminhoBanco.Text;
  FConn.Params.UserName :=edt_login.Text;
  FConn.Params.Password :=edt_Senha.Text;
  FConexao.GravarArquivoINI;
  if FConexao.Conectar_BancoDados then
    begin
      raise Exception.Create('Conex�o com o banco de dados Realizada com sucesso.');
      Application.Terminate;
    end else
            begin
              raise Exception.Create('N�o foi possivel conectar.');
              Edt_caminhoBanco.SetFocus;
            end;








end;

procedure TFrmConfiguracao.FormCreate(Sender: TObject);
begin
  inherited;
   FConn:= TFDConnection.Create(nil);
   FConf:= TConfiguration.New(ExtractFilePath(ParamStr(0))+'conf.ini');
   try
    FConn.Params.Clear;
    FConn.Params.DriverID := 'FB';
    FConn.Params.Database := Edt_caminhoBanco.Text;
    FConn.Params.UserName := edt_login.Text;
    FConn.Params.Password := edt_Senha.Text;
     if FConf.GetDriverName.Equals('SQLite') then
      FConn.Params.Add('LockingMode=Normal');
  except
    raise Exception.Create('Error ao tentar conectar com a base de dados, favor entrar em contato com o suporte');
  end;
end;

procedure TFrmConfiguracao.FormShow(Sender: TObject);
begin
  inherited;
  if FConexao.LerConfiguracao then
   edt_caminho_Atual.Text := FConf.GetCaminho;
end;

end.
