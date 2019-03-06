unit Unit1;
 
interface
 
uses
  {w sekcji uses musimy zadelkarować dodatkowo te dwa moduły} 
  UrlMon, ActiveX;
 
 
type
 {w module UrlMon jest już zdefiniowany interfejs IBindStatusCallback, niestety nie możemy go użyć w takiej formie jakiej jest, musimy zdefiniować nowy interfejs
  pokrywając tylko jego metody.
 Do rozwiązania potrzebna nam jest funkcja OnProgress, reszta może nic nie robić, ale muszą być zdefiniowane}
 
  TStatusCallback = class (TObject, IBindStatusCallback)
  public
    function OnStartBinding(dwReserved: DWORD; pib: IBinding): HResult; stdcall;
    function GetPriority(out nPriority): HResult; stdcall;
    function OnLowResource(reserved: DWORD): HResult; stdcall;
    function OnProgress(ulProgress, ulProgressMax, ulStatusCode: ULONG;
      szStatusText: LPCWSTR): HResult; stdcall;
    function OnStopBinding(hresult: HResult; szError: LPCWSTR): HResult; stdcall;
    function GetBindInfo(out grfBINDF: DWORD; var bindinfo: TBindInfo): HResult; stdcall;
    function OnDataAvailable(grfBSCF: DWORD; dwSize: DWORD; formatetc: PFormatEtc; stgmed: PStgMedium): HResult; stdcall;
    function OnObjectAvailable(const iid: TGUID; punk: IUnknown): HResult; stdcall;
 
    {poniższe fukcje nie są opisane w interfejsie IBindStatusCallback w module UrlMon (plik UrlMon.pas)
     ale są wymagane przez Delphi w opise każdego interfejsu, bez tego się nie skompliluje}
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    function QueryInterface(const IID: TGUID; out Obj): HRESULT; stdcall;
  end;
 
  TForm1 = class(TForm)
    ProgressBar1: TProgressBar;
    Button1: TButton;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
 
var
  Form1: TForm1;
 
implementation
 
{$R *.dfm}
function TStatusCallback.OnStartBinding(dwReserved: DWORD; pib: IBinding): HResult; stdcall;
begin
   result:=0;
end;
 
function TStatusCallback.GetPriority(out nPriority): HResult; stdcall;
begin
   result:=0;
end;
 
function TStatusCallback.OnLowResource(reserved: DWORD): HResult; stdcall;
begin
   result:=0;
end;
 
function TStatusCallback.OnProgress(ulProgress, ulProgressMax, ulStatusCode: ULONG; szStatusText: LPCWSTR): HResult; stdcall;
begin
{tu wykonujemy potrzebne zadania}
   Form1.ProgressBar1.Max:=ulProgressMax;
   Form1.ProgressBar1.Position:=ulProgress;
   result:=0;
end;
 
function TStatusCallback.OnStopBinding(hresult: HResult; szError: LPCWSTR): HResult; stdcall;
begin
    Form1.Edit1.Text:='Zakonczono pobieranie';
result:=0;
end;
 
function TStatusCallback.GetBindInfo(out grfBINDF: DWORD; var bindinfo: TBindInfo): HResult; stdcall;
begin
   result:=0;
end;
 
function TStatusCallback.OnDataAvailable(grfBSCF: DWORD; dwSize: DWORD; formatetc: PFormatEtc; stgmed: PStgMedium): HResult; stdcall;
begin
 
result:=0;
end;
 
function TStatusCallback.OnObjectAvailable(const iid: TGUID; punk: IUnknown): HResult; stdcall;
begin
   result:=0;
end;
 
function TStatusCallback._AddRef: Integer;
begin
 
end;
 
function TStatusCallback._Release: Integer;
begin
 
end;
 
function TStatusCallback.QueryInterface(const IID: TGUID; out Obj): HRESULT;
begin
 
end;
 
procedure TForm1.Button1Click(Sender: TObject);
var StatusCallback : TStatusCallback;
begin
    StatusCallBack:=TStatusCallback.Create;  {tworzymy interfejs StatusCallback}
    UrlDownloadToFile(nil, PChar('http://www.strona.pl/pobierany_plik.ext'), PChar('C:\pobierany_plik.ext'), 0, StatusCallBack); {wywołujemy pobieranie}
    StatusCallBack.Free; {zwalniamy interfejs}
end;
 
end.
