VERSION 5.00
Begin VB.Form Form1 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Ŀ¼������"
   ClientHeight    =   5160
   ClientLeft      =   105
   ClientTop       =   435
   ClientWidth     =   9135
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5160
   ScaleWidth      =   9135
   StartUpPosition =   3  '����ȱʡ
   Begin VB.TextBox Text2 
      BeginProperty Font 
         Name            =   "����"
         Size            =   9
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   120
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   9
      Text            =   "Form1.frx":0000
      Top             =   1800
      Width           =   2175
   End
   Begin VB.ListBox List1 
      Height          =   1680
      ItemData        =   "Form1.frx":0009
      Left            =   1320
      List            =   "Form1.frx":0010
      TabIndex        =   8
      Top             =   2520
      Width           =   6015
   End
   Begin VB.DirListBox Dir2 
      Height          =   1560
      Left            =   5880
      TabIndex        =   7
      Top             =   720
      Width           =   3135
   End
   Begin VB.DriveListBox Drive2 
      Height          =   300
      Left            =   5880
      TabIndex        =   6
      Top             =   360
      Width           =   1695
   End
   Begin VB.CommandButton Command2 
      Caption         =   "�˳�"
      Height          =   495
      Left            =   5280
      TabIndex        =   5
      Top             =   4440
      Width           =   1455
   End
   Begin VB.DirListBox Dir1 
      Height          =   1560
      Left            =   2520
      TabIndex        =   4
      Top             =   720
      Width           =   3135
   End
   Begin VB.DriveListBox Drive1 
      Height          =   300
      Left            =   2520
      TabIndex        =   3
      Top             =   360
      Width           =   1215
   End
   Begin VB.TextBox Text1 
      BeginProperty Font 
         Name            =   "����"
         Size            =   9
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   120
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   2
      Text            =   "Form1.frx":0024
      Top             =   840
      Width           =   2175
   End
   Begin VB.CommandButton Command1 
      Caption         =   "ִ��"
      Height          =   495
      Left            =   2160
      TabIndex        =   1
      Top             =   4440
      Width           =   1335
   End
   Begin VB.Label Label3 
      Caption         =   "��������"
      BeginProperty Font 
         Name            =   "����"
         Size            =   10.5
         Charset         =   134
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   12
      Top             =   1440
      Width           =   1095
   End
   Begin VB.Label Label4 
      Alignment       =   2  'Center
      BorderStyle     =   1  'Fixed Single
      Caption         =   "����λ��"
      BeginProperty Font 
         Name            =   "΢���ź�"
         Size            =   12
         Charset         =   134
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   7680
      TabIndex        =   11
      Top             =   240
      Width           =   1335
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Caption         =   "Ŀ���ļ���"
      BeginProperty Font 
         Name            =   "΢���ź�"
         Size            =   12
         Charset         =   134
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   3960
      TabIndex        =   10
      Top             =   240
      Width           =   1575
   End
   Begin VB.Label Label1 
      Caption         =   "������Ŀ¼��"
      BeginProperty Font 
         Name            =   "����"
         Size            =   10.5
         Charset         =   134
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   120
      TabIndex        =   0
      Top             =   480
      Width           =   1575
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim CurFolder As String, fstPath As String
Private Declare Function MakeSureDirectoryPathExists Lib "imagehlp.dll" (ByVal DirPath As String) As Long
Private Sub Command1_Click()
  '�б����ı����ʼ��
  List1.Clear
  Text2.Text = ""
  CurFolder = ""
  Text1.Text = Dir1.Path
  'ȷ���Ƿ��Ŀ¼
  If Len(Dir1.Path) = 3 Then
     Text2.Text = Dir2.Path
  Else:
     MkPath (Dir1.Path)
     Text2.Text = CurFolder
     List1.AddItem Text2.Text
     MakeSureDirectoryPathExists Text2.Text
  End If

  '�ݹ�Ŀ¼
  getAll (Dir1.Path)
End Sub

Private Sub Command2_Click()
  Unload Me
  End
End Sub


Private Sub Drive1_Change()
  Dir1.Path = Drive1.Drive
End Sub

Private Sub Drive2_Change()
  Dir2.Path = Drive2.Drive
End Sub

Function getAll(rootF)
  On Error Resume Next
  Dim fso As Object, folder As Object, subfolder As Object, file As Object
  Set fso = CreateObject("scripting.filesystemobject") '����FSO����
  Set folder = fso.getfolder(rootF) '�õ��ļ��ж���

  For Each subfolder In folder.SubFolders '�������ļ���
    Call MkPath(subfolder)
    List1.AddItem CurFolder
    List1.Refresh
    '����Ŀ¼
    MakeSureDirectoryPathExists CurFolder
   ''�������ֽ��ı���ռλ
    'Open CurFolder & "\readme.txt" For Output As #1
    'Close #1
    Call getAll(subfolder) '�ݹ�,���Ҹ��ļ��е����ļ���
  Next
  Set fso = Nothing
  Set folder = Nothing
  Set fso = Nothing
End Function

Function MkPath(ByVal sPath As String)
'��ֳ�ʼĿ¼��ȥ���������Ų�����·���޽ӵ�Ŀ��Ŀ¼����
  Dim i As Long
  Dim Splits() As String

  Splits = Split(sPath, "\")
  If Len(Dir2.Path) = 3 Then
     CurFolder = Dir2.Path
  Else:
     CurFolder = Dir2.Path & "\"
  End If
  For i = 1 To UBound(Splits)
    CurFolder = CurFolder & Splits(i) & "\"
  Next i
End Function

