unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    Label7: TLabel;
    EdtArquivoOriginal: TEdit;
    btnProcesso: TBitBtn;
    SpeedButton2: TSpeedButton;
    OpenDialog1: TOpenDialog;
    ListBox1: TListBox;
    Label1: TLabel;
    editNcm: TEdit;
    Label2: TLabel;
    ComboBox1: TComboBox;
    procedure SpeedButton2Click(Sender: TObject);
    procedure Split(Str: string; Delimiter: Char; ListOfStrings: TStrings);
    procedure BuscarAliquota(caminhoarquivo, ncm, nacional :String);
    procedure btnProcessoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
 if OpenDialog1.Execute then
   EdtArquivoOriginal.Text := OpenDialog1.FileName;

end;

procedure TForm1.Split(Str: string; Delimiter: Char; ListOfStrings: TStrings);
begin
    //ListOfStrings.StrictDelimiter := True;
    ListOfStrings.Clear;
    ListOfStrings.Delimiter       := Delimiter;
    ListOfStrings.DelimitedText   := Str;
end;




procedure TForm1.BuscarAliquota(caminhoarquivo, ncm, nacional: String);
var
   slItens, slDados: TStringList;
   QtdLinhasTotal, y :Integer;
   sLinha, id, alNacional, alImportacao :string;
begin
   slItens := TStringList.Create;
   slDados := TStringList.Create;

      //limpa o listBox
   ListBox1.Clear;

   slItens.LoadFromFile(caminhoarquivo);
   QtdLinhasTotal := slItens.Count - 1;

    for y := 1 to Pred( QtdLinhasTotal ) do
    begin
      sLinha := slItens[y];
     // ShowMessage(sLinha );
      Split( sLinha, ';', slDados );

      id          :=  slDados[0];
      alNacional  :=  slDados[3];
      alImportacao:=  slDados[4];


      if (id = ncm) then
       begin

         if (nacional = 'S') then
          begin
            ListBox1.Items.Add('NCM = ' + slDados[0]);
            ListBox1.Items.Add('ALIQ = ' + slDados[3]);
          end
         else
          begin
            ListBox1.Items.Add('NCM = ' + slDados[0]);
            ListBox1.Items.Add('ALIQ = ' + slDados[4]);
          end;

         Break;
      end;


    end;

     slItens.Free;
     slDados.Free;

end;

procedure TForm1.btnProcessoClick(Sender: TObject);
begin
  BuscarAliquota(EdtArquivoOriginal.Text,editNcm.Text,ComboBox1.Text);
end;

end.
