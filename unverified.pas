unit unverified;

interface

uses
  // Delphi
  System.Classes,
  System.SysUtils,
  // FireMonkey
  FMX.Controls,
  FMX.Controls.Presentation,
  FMX.Objects,
  FMX.StdCtrls,
  FMX.Types,
  // web3
  web3,
  // project
  base;

type
  TFrmUnverified = class(TFrmBase)
    lblTitle: TLabel;
    lblContractTitle: TLabel;
    btnAllow: TButton;
    btnBlock: TButton;
    lblContractText: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    procedure btnBlockClick(Sender: TObject);
    procedure btnAllowClick(Sender: TObject);
    procedure lblContractTextClick(Sender: TObject);
  strict private
    FChain: TChain;
    FCallback: TProc<Boolean>;
    procedure SetContract(contract: TAddress);
  public
    property Chain: TChain write FChain;
    property Contract: TAddress write SetContract;
    property Callback: TProc<Boolean> write FCallback;
  end;

procedure show(chain: TChain; contract: TAddress; callback: TProc<Boolean>);

implementation

uses
  // FireMonkey
  FMX.Forms,
  // project
  common;

{$R *.fmx}

procedure show(chain: TChain; contract: TAddress; callback: TProc<Boolean>);
begin
  const frmUnverified = TFrmUnverified.Create(Application);
  frmUnverified.Chain := chain;
  frmUnverified.Contract := contract;
  frmUnverified.Callback := callback;
  frmUnverified.Show;
end;

{ TFrmUnverified }

procedure TFrmUnverified.SetContract(contract: TAddress);
begin
  lblContractText.Text := string(contract);
end;

procedure TFrmUnverified.lblContractTextClick(Sender: TObject);
begin
  common.open(Self.FChain.BlockExplorer + '/address/' + lblContractText.Text + '#code');
end;

procedure TFrmUnverified.btnBlockClick(Sender: TObject);
begin
  if Assigned(Self.FCallback) then Self.FCallback(False);
  Self.Close;
end;

procedure TFrmUnverified.btnAllowClick(Sender: TObject);
begin
  if Assigned(Self.FCallback) then Self.FCallback(True);
  Self.Close;
end;

end.
