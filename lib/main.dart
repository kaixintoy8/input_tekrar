import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MyProject());
  }
}

class MyProject extends StatelessWidget {
  const MyProject({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("İnput Tekrar"),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),
      body: TextFormFieldKullanimi(),
    );
  }
}

class TextFieldWidgetKullanimi extends StatefulWidget {
  const TextFieldWidgetKullanimi({super.key});

  @override
  State<TextFieldWidgetKullanimi> createState() =>
      _TextFieldWidgetKullanimiState();
}

class _TextFieldWidgetKullanimiState extends State<TextFieldWidgetKullanimi> {
  late TextEditingController
  _emailController; // _ private olduğu anlamına gelir.
  late FocusNode _focusNode;
  int maxLineCount = 1;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(
      // text: "begumtoy@hotmail.com" /*bu parametre varsayılan değer*/,
    ); //Özellikle altına yazıldı.
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        maxLineCount = _focusNode.hasFocus ? 3 : 1;
      });
    });
  }

  @override
  void dispose() {
    //Kalıcı olan verileri siler
    _emailController.dispose(); //Özellikle üste yazıldı.
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldWidKullanimi(
      focusNode: _focusNode,
      emailController: _emailController,
      maxLineCount: maxLineCount,
    );
  }
}

class TextFieldWidKullanimi extends StatelessWidget {
  const TextFieldWidKullanimi({
    super.key,
    required FocusNode focusNode,
    required TextEditingController emailController,
    required this.maxLineCount,
  }) : _focusNode = focusNode,
       _emailController = emailController;

  final FocusNode _focusNode;
  final TextEditingController _emailController;
  final int maxLineCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: TextField(
            focusNode: _focusNode,
            controller: _emailController,
            //Açılacak olan klavye türü
            keyboardType: TextInputType.emailAddress,
            //Klavyedeki(Android) ana butonunun ne olacağı
            textInputAction: TextInputAction.done,

            //Seçili gelme olayı
            // autofocus: true,

            //Satır sayısı
            maxLines: maxLineCount, //
            //Girilecek karakter sayısı (TC)
            maxLength: 30,

            //İmleç rengi
            cursorColor: Colors.red,
            decoration: InputDecoration(
              //Kayan bilgi yazısı
              labelText: "Username",
              //İpucu
              hintText: "Kullanıcı adınızı giriniz",
              icon: Icon(Icons.add),
              //Sol tarafa eklenen icon
              prefix: Icon(Icons.person),
              //Sağ taraf iconu
              suffixIcon: Icon(Icons.cancel),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              //Arka plan rengi verme izni
              filled: true,
              fillColor: Colors.green.shade300,
            ),
            //Klavye ile yapılan her değişikliği algılar
            onChanged: (String gelenDeger) {},
            //Klavyedeki done tuşuna basınca çalışır ya da fiel dan çıkınca
            onSubmitted: (String gelenDeger) {},
          ),
        ),
        TextField(),
      ],
    );
  }
}
/*

Veri almak için controllerlar gerek
Controllerları textformfield larda kullanmıyoruz.
Bütün controllerlar hafızada kalır.
İnitialize oluşturma işlemleir init state içinde yapılır. Çünkü bir kere çalışır.
*/

class TextFormFieldKullanimi extends StatefulWidget {
  const TextFormFieldKullanimi({super.key});

  @override
  State<TextFormFieldKullanimi> createState() => _TextFormFieldKullanimiState();
}

class _TextFormFieldKullanimiState extends State<TextFormFieldKullanimi> {
  late final String
  _email,
  _password,
  _userName; //eğer ="" , yapmamışsak başın late eklememiz lazım. Yapıldıysa baştaki finalı da silmemiz gerekir.

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Form(
          //validate işleminin ne zaman çalışacağını belirler.
          autovalidateMode: AutovalidateMode
              .onUserInteraction, //kullanıcı veri girmeye başladığında uyarıları ver.
          //TextFormFieldın, TextEditingController a ihtiyacı yoktur. Textfieldın controllora ihityacı vardır.
          child: Column(
            children: [
              TextFormField(
                onSaved: (gelenUsername) {
                  _userName = gelenUsername!;
                },
                //varsayılan değeri tanımlar.
                //initialValue: "begumtoy",
                decoration: InputDecoration(
                  //hata mesajlarının rengini değiştirir
                  errorStyle: TextStyle(color: Colors.orange),
                  labelText: "USERNAME ",
                  hintText: "Username",
                  border: OutlineInputBorder(),
                ),
                validator: (girilenUsername) {
                  if (girilenUsername!.isEmpty) {
                    return "Kullanıcı adı boş olamaz";
                  }
                  if (girilenUsername.length < 4) {
                    //girilenUsername sonuna ! koymuştuk yukarıdaki if i yazmadan önce bunun sebei boş gelmes olasılığına karşı önlem almaktı. Ancak yukarıdaki if sayesinde zaten boş gelme olasılığını ortadan kaldırıyoruz. ! konulmasına gerek kalmadı.
                    return "4 karakterden az olamaz";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                onSaved: (gelenEmail) {
                  _email = gelenEmail!;
                },
                //varsayılan değeri tanımlar.
                //initialValue: "begumtoy",
                decoration: InputDecoration(
                  //hata mesajlarının rengini değiştirir
                  errorStyle: TextStyle(color: Colors.orange),
                  labelText: "EMAİL ",
                  hintText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (girilenEmail) {
                  if (!EmailValidator.validate(girilenEmail!)) {
                    return "Geçerli bir mail giriniz";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                onSaved: (gelenPasword) {
                  _password = gelenPasword!;
                },
                //varsayılan değeri tanımlar
                //initialValue: "bilalkarademir",
                decoration: InputDecoration(
                  //hata mesajlarının rengini değiştirir
                  errorStyle: TextStyle(color: Colors.orange),
                  labelText: "PASSWORD",
                  hintText: "Password",
                  border: OutlineInputBorder(),
                ),
                validator: (girilenPass) {
                  if (girilenPass!.isEmpty) {
                    return "Şİfre boş olamaz";
                  }
                  if (girilenPass.length < 4) {
                    return "4 karakterden az olamaz";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 55,
                width: 180,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown.shade500,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.brown, width: 3),
                    ),
                  ),
                  onPressed: () {
                    //validate tamamlandı mı kontrol etmek için
                    bool _isValidate = _formKey.currentState!.validate();
                    if (_isValidate) {
                      //textformField dan gelen verileri kaydetme işlemi
                      _formKey.currentState!.save();
                      String result =
                          "username: $_userName\nemail:$_email\nsifre: $_password";
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            result,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      );
                      //save işlemi olduktan sonra textformfieldları temizler
                      _formKey.currentState!.reset();
                    }
                  },
                  child: Text("Onayla"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
