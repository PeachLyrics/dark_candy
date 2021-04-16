import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'DarkCandy',

    //Tema
    theme: ThemeData(
      primaryColor: Colors.pinkAccent,
      backgroundColor: Colors.white,
      textTheme: TextTheme(headline1: TextStyle(fontSize: 10), headline2: TextStyle(fontSize: 20), headline3: TextStyle(fontSize: 20, color: Colors.white)),
    ),

    //ROTAS DE NAVEGAÇÃO
    initialRoute: '/primeira',
    routes: {
      '/primeira': (context) => TeladeLogin(),
      /*'/segunda': (context) => SegundaTela(),
      '/terceira': (context) => TerceiraTela(),
      '/quarta': (context) => QuartaTela(),*/
    },
  ));
}

class Mensagem{
  final String login;
  final String senha;
  Mensagem(this.login,this.senha);
}

//
// PRIMEIRA TELA
//

class TeladeLogin extends StatefulWidget {
  @override
  _TeladeLoginState createState() => _TeladeLoginState();
}

class _TeladeLoginState extends State<TeladeLogin> {

  var txtLogin = TextEditingController();
  var txtSenha = TextEditingController();

  //Atributo para identificar unicamente o campo do usuário
  var clearID = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('DarkCandy'),centerTitle: true,
      actions: [
          IconButton(icon: Icon(Icons.delete_rounded),
          onPressed: (){
            setState(() {
              txtLogin.clear();
              txtSenha.clear();
              FocusScope.of(context).unfocus();
            });
          },
          )
        ],
        ),
      body: SingleChildScrollView(
              child: Container(
          padding: EdgeInsets.all(40),
          child: Form(
            key: clearID,
              child: Column(children: [
              Icon(Icons.person_sharp,
                size: 120, 
                color:  Theme.of(context).primaryColor
              ),

              campoTexto('Nome de usuário', txtLogin),
              campoTexto('Senha', txtSenha),
              botao('Login'),

            ]),
          ),
        ),
      ),
    );
  }

  //Campo de texto para a entrada de dados

  Widget campoTexto(rotulo,variavel){
    return Container(
    padding: EdgeInsets.symmetric(vertical: 10),
    child: TextFormField(
      //Variável que receberá o valor contido no campo de texto
      controller: variavel,
      style: Theme.of(context).textTheme.headline2,
      decoration: InputDecoration(
        labelText: rotulo,
        labelStyle: Theme.of(context).textTheme.headline2,
        hintText: 'Entre com suas informações',
        hintStyle: Theme.of(context).textTheme.headline1,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        )
      ),

    ),
    );
  }

  //Botão

  Widget botao(rotulo){
    return Container(
      padding: EdgeInsets.only(top: 20),
      width: double.infinity,
      height: 70,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states){
              if(states.contains(MaterialState.pressed))
              return Colors.pinkAccent;
              return Colors.pink[700];
            },
          ),),
        child: Text(rotulo, style: Theme.of(context).textTheme.headline3),
        onPressed: (){
          //print('botão pressionado!');
          
        },
      ),
    );
  }
}