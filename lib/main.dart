import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'DarkCandy',

    //Tema
    theme: ThemeData(
      primaryColor: Colors.indigo[700],
      backgroundColor: Colors.white,
      textTheme: TextTheme(headline1: TextStyle(fontSize: 10), headline2: TextStyle(fontSize: 20), headline3: TextStyle(fontSize: 20, color: Colors.white)),
    ),

    //ROTAS DE NAVEGAÇÃO
    initialRoute: '/primeira',
    routes: {
      '/primeira': (context) => TeladeLogin(),
      '/segunda': (context) => MenuPrincipal(),
       /*'/Perfil': (context) => TerceiraTela(),
      '/Galeria': (context) => QuartaTela(),
      '/Pedido': (context) => QuintaTela(),
      '/Carrinho': (context) => SextaTela(),
      '/Sobre': (context) => SetimaTela(),
      '/Ajuda': (context) => OitavaTela(),*/
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
              Image.asset('lib/images/dark-candy-water-mark.PNG'),

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
              return Colors.indigo[900];
              return Colors.indigo[700];
            },
          ),),
        child: Text(rotulo, style: Theme.of(context).textTheme.headline3),
        onPressed: (){
          Navigator.pushNamed(context, '/segunda');
        },
      ),
    );
  }
}

//
// MENU PRINCIPAL
//
class MenuPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('EXPLORADOR'), centerTitle: true ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(40),

        //
        // LISTVIEW
        //
        child: ListView(
          children: [
            
            Text('Lista de opções',
                 style: TextStyle(fontSize: 30, color:Colors.black),
            ),
            SizedBox(height: 40),

            ListTile(
              
              leading: Icon(Icons.arrow_forward, color: Colors.pink[400]),
              trailing: Icon(Icons.person, color: Colors.indigo[700]),
              title: Text('PERFIL', style: TextStyle(fontSize: 32, color:Colors.black)),
              
              onTap: (){
                print('item pressionado');
                Navigator.pushNamed(context, '/Perfil');
              },
              hoverColor: Colors.indigo[00],

            ),

            ListTile(
              leading: Icon(Icons.arrow_forward, color: Colors.pink[400]),
              trailing: Icon(Icons.photo_library, color: Colors.indigo[700]),
              title: Text('GALERIA', style: TextStyle(fontSize: 32, color:Colors.black)),
              
              onTap: (){
                print('item pressionado');
                Navigator.pushNamed(context, '/Galeria');
              },
              hoverColor: Colors.indigo[00],
            ),

            ListTile(
              leading: Icon(Icons.arrow_forward, color: Colors.pink[400]),
              trailing: Icon(Icons.content_cut,color: Colors.indigo[700]),
              title: Text('PEDIDO', style: TextStyle(fontSize: 32, color:Colors.black)),
              
              onTap: (){
                print('item pressionado');
                Navigator.pushNamed(context, '/Pedido');
              },
              hoverColor: Colors.indigo[00],
            ),

            ListTile(
              leading: Icon(Icons.arrow_forward, color: Colors.pink[400]),
              trailing: Icon(Icons.shopping_cart, color: Colors.indigo[700]),
              title: Text('CARRINHO', style: TextStyle(fontSize: 32, color:Colors.black)),
              
              onTap: (){
                print('item pressionado');
                Navigator.pushNamed(context, '/Carrinho');
              },
              hoverColor: Colors.indigo[00],
            ),

            ListTile(
              leading: Icon(Icons.arrow_forward, color: Colors.pink[400]),
              trailing: Icon(Icons.bookmark_border, color: Colors.indigo[700]),
              title: Text('SOBRE', style: TextStyle(fontSize: 32, color:Colors.black)),
              
              onTap: (){
                print('item pressionado');
                Navigator.pushNamed(context, '/Sobre');
              },
              hoverColor: Colors.indigo[00],
            ),

            ListTile(
              leading: Icon(Icons.arrow_forward, color: Colors.pink[400]),
              trailing: Icon(Icons.accessibility, color: Colors.indigo[700]),
              title: Text('AJUDA', style: TextStyle(fontSize: 32, color:Colors.black)),
              
              onTap: (){
                print('item pressionado');
                Navigator.pushNamed(context, '/Ajuda');
              },
              hoverColor: Colors.indigo[00],
            ),
          ],
        ),
      ),
    );
  }

}