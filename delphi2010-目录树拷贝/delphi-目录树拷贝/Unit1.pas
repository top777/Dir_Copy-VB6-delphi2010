unit Unit1;

interface
{$WARN UNIT_PLATFORM OFF}
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Types, IOUtils, FileCtrl;
type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    DriveComboBox1: TDriveComboBox;
    DriveComboBox2: TDriveComboBox;
    DirectoryListBox1: TDirectoryListBox;
    DirectoryListBox2: TDirectoryListBox;
    Edit1: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DriveComboBox1Change(Sender: TObject);
    procedure DriveComboBox2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DirectoryListBox1Change(Sender: TObject);
  private
    procedure ListFiless(FilePath: string);
    procedure CreatDirs(DirName: string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  constr, FilePath, DirName: string;
implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  application.terminate;
end;

procedure TForm1.Button2Click(Sender: TObject);

begin
//memo��ʼ��
  Memo1.Clear;
  Memo1.Lines.Add('���Ƶ�Ŀ¼Ϊ��');
//�ж��Ƿ��Ŀ¼
  if DirectoryListBox2.Directory = DirectoryListBox2.Drive + ':\' then
    FilePath := DirectoryListBox2.Drive + ':'
  else FilePath := DirectoryListBox2.Directory;
  constr := DirectoryListBox1.Directory;
//�����ӳ�����Ŀ¼��
  CreatDirs(constr);
end;

procedure TForm1.DirectoryListBox1Change(Sender: TObject);
begin
  Edit1.Text := DirectoryListBox1.Directory;
end;

procedure TForm1.DriveComboBox1Change(Sender: TObject);
begin
  DirectoryListBox1.Drive := DriveComboBox1.Drive
end;

procedure TForm1.DriveComboBox2Change(Sender: TObject);
begin
  DirectoryListBox2.Drive := DriveComboBox2.Drive
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Application.BringToFront;
  edit1.ReadOnly := True;
end;


procedure TForm1.ListFiless(FilePath: string);
var
  FileList: TStringDynArray;
  FileName: string;
begin
  // ��ȡ��ǰ·���µ������ļ�
  FileList := TDirectory.GetFiles(FilePath);
  //�������飬��ȡ�ļ���Ϣ
  for FileName in FileList do begin
    Self.Memo1.Lines.Add(FileName);
  end;
end;

procedure TForm1.CreatDirs(DirName: string);
var
  DirList: TStringDynArray;
  Name, strPath: string;
  strs: TStrings;
  i: Integer;

begin
//������ʼĿ¼·����ע����ʼĿ¼�ʹ��λ�ò�Ҫ���ص���������γ�ѭ��
  strPath := FilePath;
  strs := TStringList.Create;
  strs.StrictDelimiter := True; //���οո�Ϊ�ָ���
  strs.Delimiter := '\';
  strs.DelimitedText := DirName;
  for i := 1 to Strs.Count - 1 do
    strPath := strPath + '\' + strs[i];
   // ��ȡĳ��·���µ������ļ���
  if strPath = DirectoryListBox2.Drive + ':\' then
    Self.Memo1.Lines.Add('��Ŀ¼����')
  else
  begin
  //��memo����ʾ������Ŀ¼������Ŀ¼
    Self.Memo1.Lines.Add(strPath);
    ForceDirectories(strPath);
  end;
  DirList := TDirectory.GetDirectories(DirName);
  // ��������ȡÿһ���ļ���(·��)
  for Name in DirList do begin
    CreatDirs(Name);
  end;

end;


end.

