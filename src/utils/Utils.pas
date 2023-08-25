unit Utils;

interface

uses
  Vcl.Forms,
  System.SysUtils,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  model.query,
  util.interfaces;
type
 TUtil = class(TInterfacedObject, iUtils)
   private
    FParent: IInterface;
    FQuery: iQuery;
    public
    constructor Create(Parent: IInterface);
    destructor Destroy; override;
    procedure ValidarCamposObrigatorio(Form: TForm);
    class function New(Parent: IInterface): iUtils;
    function Query: iQuery;

 end;




implementation

procedure TUtil.ValidarCamposObrigatorio(Form: TForm);
 begin
   var
  i: Integer;
begin
  for i := 0 to Form.ComponentCount - 1 do
  begin
    if Form.Components[i].Tag = 5 then
    begin
      if Form.Components[i] is Tedit then
        if ((Form.Components[i] as Tedit).hint <> '') and ((Form.Components[i] as Tedit).text = '') then
        begin
          MessageDlg('Aviso de dados Obrigatório'+ (Form.Components[i] as Tedit).hint,
          mtWarning,[mbOK],0);
           Abort;
        end;
        end;
    end;
  end;
 end;

{ TUtil }

constructor TUtil.Create(Parent: IInterface);
begin
   FParent:= Parent;
end;

destructor TUtil.Destroy;
begin

  inherited;
end;

class function TUtil.New(Parent: IInterface): iUtils;
begin
   Result := Self.Create(Parent);
end;

function TUtil.Query: iQuery;
begin
  { if not Assigned(FQuery) then
    FQuery := TQuery.New(FParent);
  Result := FQuery; }
end;

end.
