import 'dart:js';

import 'package:path/path.dart';
import 'package:dark_candy/Galeria.dart';
import 'package:flutter/material.dart';
import 'package:dark_candy/PerfilDev.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dark_candy/Usuario.dart';
import 'package:dark_candy/Biografias.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'DarkCandy',

    //Tema
    theme: ThemeData(
      primaryColor: Colors.pink[200],
      backgroundColor: Colors.white,
      textTheme: TextTheme(headline1: TextStyle(fontSize: 10), headline2: TextStyle(fontSize: 20), headline3: TextStyle(fontSize: 20, color: Colors.white)),
    ),

    //ROTAS DE NAVEGAÇÃO
    initialRoute: '/primeira',
    routes: {
      '/primeira': (context) => TeladeLogin(),
      '/segunda': (context) => MenuPrincipal(),
      '/Perfil': (context) => Perfil(),
      '/Galeria': (context) => Galeria(),
      '/Pedido': (context) => Pedido(),
      '/Carrinho': (context) => Carrinho(),
      '/Sobre': (context) => Sobre(),
      '/Ajuda': (context) => Ajuda(),
      '/Parte de cima': (context) => PartCima(),
      '/Parte de baixo': (context) => PartBaixo(),
      '/Conjunto': (context) => Conjunto(),
      '/Nova conta': (context) => NovaConta(),
      '/Cadastro Bio': (context) => TelaCadastroBio(),
    },
  ));
}

class Mensagem{
  String login;
  Mensagem(this.login);
}

//
// PRIMEIRA TELA - Léo
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

              campoTexto('E-mail', txtLogin),
              campoTextoSenha('Senha', txtSenha),
              botaologin('Login'),
              botaonovaconta('Nova conta')

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
      style: Theme.of(this.context).textTheme.headline2,
      decoration: InputDecoration(
        labelText: rotulo,
        labelStyle: Theme.of(this.context).textTheme.headline2,
        hintText: 'Entre com suas informações',
        hintStyle: Theme.of(this.context).textTheme.headline1,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        )
      ),

    ),
    );
  }

  Widget campoTextoSenha(rotulo,variavel){
    return Container(
    padding: EdgeInsets.symmetric(vertical: 10),
    child: TextFormField(
      obscureText: true,
      //Variável que receberá o valor contido no campo de texto
      controller: variavel,
      style: Theme.of(this.context).textTheme.headline2,
      decoration: InputDecoration(
        labelText: rotulo,
        labelStyle: Theme.of(this.context).textTheme.headline2,
        hintText: 'Entre com suas informações',
        hintStyle: Theme.of(this.context).textTheme.headline1,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        )
      ),

    ),
    );
  }

  //Botão de login

  Widget botaologin(rotulo){
    return Container(
      padding: EdgeInsets.only(top: 20),
      width: double.infinity,
      height: 70,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states){
              if(states.contains(MaterialState.pressed))
              return Colors.pink[300];
              return Colors.pink[100];
            },
          ),),
        child: Text(rotulo, style: Theme.of(this.context).textTheme.headline3),
        onPressed: (){
          login(txtLogin.text, txtSenha.text);
        },
      ),
    );
  }

  //Botão para criar nova conta
  Widget botaonovaconta(rotulo){
    return Container(
      padding: EdgeInsets.only(top: 20),
      width: double.infinity,
      height: 70,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states){
              if(states.contains(MaterialState.pressed))
              return Colors.pink[300];
              return Colors.pink[100];
            },
          ),),
        child: Text(rotulo, style: Theme.of(this.context).textTheme.headline3),
        onPressed: (){
          var msg = Mensagem (
                txtLogin.text,
              );
          Navigator.pushNamed(this.context, '/Nova conta', arguments: msg);
        },
      ),
    );
  }

  void login(email, senha){

    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email, password: senha).then((resultado) {

        Navigator.pushReplacementNamed(
          this.context, '/segunda', arguments: resultado.user.uid);

    }).catchError((erro){

      var errorCode = erro.code;
      var mensagemdeerro = '';
      if (errorCode == 'user-not-found'){
        mensagemdeerro = 'ユーザーが見つかりません。';
      }else if (errorCode == 'wrong-password'){
        mensagemdeerro = '無効なパスワード。';
      }else if (errorCode == 'invalid-email'){
        mensagemdeerro = '無効なメール。';
      }else{
        mensagemdeerro = erro.message;
      }
      ScaffoldMessenger.of(this.context).showSnackBar(
        SnackBar(
          content: Text('エラー: $mensagemdeerro'),
          duration: Duration(seconds: 2),
        )
      );

    });

  }
}

class MenuPrincipal extends StatefulWidget {
  @override
  _MenuPrincipalState createState() => _MenuPrincipalState();
}

//
// MENU PRINCIPAL - Victor
//
class _MenuPrincipalState extends State<MenuPrincipal> {

  CollectionReference usuar;

  @override
  void initState() {
    super.initState();
    usuar = FirebaseFirestore.instance.collection('usuarios');
  }

  Widget itemLista(item) {
    Usuario usu = Usuario.fromJson(item.data(), item.id);
    return ListTile(
      title: Text('Seja bem vindo(a): '+usu.nome, style: TextStyle(fontSize: 24)),
    );
  }

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
            StreamBuilder<QuerySnapshot>(

          //fonte de dados
          stream: usuar.snapshots(),

          //aparência
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(child: Text('Erro ao conectar no Firebase'));

              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());

              default:
                final dados = snapshot.requireData;

                return SizedBox(
                  height: 50,
                      child: ListView.builder(
                      itemCount: dados.size,
                      itemBuilder: (context, index) {
                        return itemLista(dados.docs[index]);
                      }
                  ),
                );
            }
          }),

            Text('Lista de opções',
                 style: TextStyle(fontSize: 30, color:Colors.black),
            ),
            SizedBox(height: 40),

            ListTile(
              
              leading: Icon(Icons.arrow_forward, color: Colors.pink[400]),
              trailing: Icon(Icons.person, color: Colors.pink[400]),
              title: Text('PERFIL', style: TextStyle(fontSize: 32, color:Colors.black)),
              
              onTap: (){
                print('item pressionado');
                Navigator.pushNamed(context, '/Perfil');
              },
              hoverColor: Colors.pink[100],

            ),

            ListTile(
              leading: Icon(Icons.arrow_forward, color: Colors.pink[400]),
              trailing: Icon(Icons.photo_library, color: Colors.pink[400]),
              title: Text('GALERIA', style: TextStyle(fontSize: 32, color:Colors.black)),
              
              onTap: (){
                print('item pressionado');
                Navigator.pushNamed(context, '/Galeria');
              },
              hoverColor: Colors.pink[100],
            ),

            ListTile(
              leading: Icon(Icons.arrow_forward, color: Colors.pink[400]),
              trailing: Icon(Icons.content_cut,color: Colors.pink[400]),
              title: Text('PEDIDO', style: TextStyle(fontSize: 32, color:Colors.black)),
              
              onTap: (){
                print('item pressionado');
                Navigator.pushNamed(context, '/Pedido');
              },
              hoverColor: Colors.pink[100],
            ),

            ListTile(
              leading: Icon(Icons.arrow_forward, color: Colors.pink[400]),
              trailing: Icon(Icons.bookmark_border, color: Colors.pink[400]),
              title: Text('SOBRE', style: TextStyle(fontSize: 32, color:Colors.black)),
              
              onTap: (){
                print('item pressionado');
                Navigator.pushNamed(context, '/Sobre');
              },
              hoverColor: Colors.pink[100],
            ),

            ListTile(
              leading: Icon(Icons.arrow_forward, color: Colors.pink[400]),
              trailing: Icon(Icons.accessibility, color: Colors.pink[400]),
              title: Text('AJUDA', style: TextStyle(fontSize: 32, color:Colors.black)),
              
              onTap: (){
                print('item pressionado');
                Navigator.pushNamed(context, '/Ajuda');
              },
              hoverColor: Colors.pink[100],
            ),
          ],
        ),
      ),
    );
  }

}

//
// Tela do Perfil - Léo
//
class Perfil extends StatefulWidget{
  @override
  _PerfilState createState() => _PerfilState();
}
class _PerfilState extends State<Perfil>{
  
  final txtBio = TextEditingController();
  CollectionReference bios;

  @override
  void initState() {
    super.initState();
    bios = FirebaseFirestore.instance.collection('bio');
  }

  Widget itemLista(item) {
    Biografias bio = Biografias.fromJson(item.data(), item.id);
    return ListTile(
      title: Text(bio.biografia, style: TextStyle(fontSize: 24)),
      trailing: IconButton(
        icon: Icon(Icons.delete, color: Colors.pinkAccent,),
        onPressed: () {
          // Apagar um café
          bios.doc(bio.id).delete();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //var msg = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),centerTitle: true,

        //Remover o ícone de Voltar
        automaticallyImplyLeading: false,
        
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, 
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.supervised_user_circle, color: Colors.white, size: 300),
                SizedBox(height: 40),
              ],
            ),

            StreamBuilder<QuerySnapshot>(

          //fonte de dados
          stream: bios.snapshots(),

          //aparência
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(child: Text('Erro ao conectar no Firebase'));

              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());

              default:
                final dados = snapshot.requireData;

                return Expanded(
                      child: ListView.builder(
                      itemCount: dados.size,
                      itemBuilder: (context, index) {
                        return itemLista(dados.docs[index]);
                      }
                  ),
                );
            }
          }),
          botaoVoltar('Voltar')
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.pinkAccent,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/Cadastro Bio');
        },
      ),
    );
  }
  
  Widget botaoVoltar(rotulo){
    return Container(
      padding: EdgeInsets.only(top: 20),
      width: double.infinity,
      height: 70,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states){
              if(states.contains(MaterialState.pressed))
              return Colors.pink[300];
              return Colors.pink[100];
            },
          ),),
        child: Text(rotulo, style: Theme.of(this.context).textTheme.headline3),
        onPressed: (){
          //Voltar para PrimeiraTela()
          Navigator.pop(this.context, '/segunda');
        },
      ),
    );
  }
}

//
//Tela da Galeria - Léo
//
class Galeria extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Galeria'),centerTitle: true,

        //Remover o ícone de Voltar
        automaticallyImplyLeading: false,
        
      ),
      body: Container(
        child: ListView(
          children: [
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              OutlinedButton(
                child: Text('Voltar'),
                onPressed: () {

                  //Voltar para PrimeiraTela()
                  Navigator.pop(context, '/segunda');

                },
              ),
            ],
          ),
           SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.arrow_forward, color: Colors.pink[400]),
              title: Text('Parte de cima', style: TextStyle(fontSize: 32, color:Colors.black)),
              
              onTap: (){
                print('item pressionado');
                Navigator.pushNamed(context, '/Parte de cima');
              },
              hoverColor: Colors.pink[100],
            ),
            SizedBox(height: 5),
            ListTile(
              leading: Icon(Icons.arrow_forward, color: Colors.pink[400]),
              title: Text('Parte de baixo', style: TextStyle(fontSize: 32, color:Colors.black)),
              
              onTap: (){
                print('item pressionado');
                Navigator.pushNamed(context, '/Parte de baixo');
              },
              hoverColor: Colors.pink[100],
            ),
            SizedBox(height: 5),
            ListTile(
              leading: Icon(Icons.arrow_forward, color: Colors.pink[400]),
              title: Text('Conjunto', style: TextStyle(fontSize: 32, color:Colors.black)),
              
              onTap: (){
                print('item pressionado');
                Navigator.pushNamed(context, '/Conjunto');
              },
              hoverColor: Colors.pink[100],
            ),
          ],
        )
      ),
    );
  }
}

class PartCima extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Parte de cima'),centerTitle: true,

        //Remover o ícone de Voltar
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              OutlinedButton(
                child: Text('Voltar'),
                onPressed: () {

                  //Voltar para PrimeiraTela()
                  Navigator.pop(context, '/Galeria');

                },
              ),
            ],
          ),
          SizedBox(height: 20),
            GaleriaWidget('lib/images/Parte de cima.png'),
            GaleriaWidget('lib/images/Parte de cima 2.png'),
            GaleriaWidget('lib/images/Parte de cima 5.png'),
          ],
        ),
      )
    );
  }
}
class PartBaixo extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Parte de baixo'),centerTitle: true,

        //Remover o ícone de Voltar
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              OutlinedButton(
                child: Text('Voltar'),
                onPressed: () {

                  //Voltar para PrimeiraTela()
                  Navigator.pop(context, '/Galeria');

                },
              ),
            ],
          ),
          SizedBox(height: 20),
            GaleriaWidget('lib/images/Parte de baixo.png'),
            GaleriaWidget('lib/images/Parte de baixo 2.png'),
          ],
        ),
      )
    );
  }
}
class Conjunto extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Conjunto'),centerTitle: true,

        //Remover o ícone de Voltar
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              OutlinedButton(
                child: Text('Voltar'),
                onPressed: () {

                  //Voltar para PrimeiraTela()
                  Navigator.pop(context, '/Galeria');

                },
              ),
            ],
          ),
          SizedBox(height: 20),
            GaleriaWidget('lib/images/Conjunto.png'),
            GaleriaWidget('lib/images/Conjunto 2.png'),
            GaleriaWidget('lib/images/Conjunto 3.png'),
            GaleriaWidget('lib/images/Conjunto 4.png'),
            GaleriaWidget('lib/images/Conjunto 5.png'),
            GaleriaWidget('lib/images/Conjunto 6.png'),
          ],
        ),
      )
    );
  }
}

//
//Tela do Pedido - Victor
//
class pedidoc {
  final String pescoco;
  final String ombro;
  final String busto;
  final String cintura;
  final String quadril;
  final String comprimento_do_corpo;
  final String braco;
  final String perna;
  final String costas;
  final String canela;
   String valor;
  pedidoc(
      this.pescoco,
      this.ombro,
      this.busto,
      this.cintura,
      this.quadril,
      this.comprimento_do_corpo,
      this.braco,
      this.perna,
      this.costas,
      this.canela,
      this.valor);
}

class Pedido extends StatefulWidget {
  @override
  _PedidoTelaState createState() => _PedidoTelaState();
}

class _PedidoTelaState extends State<Pedido> {
  var txtPescoco = TextEditingController();
  var txtOmbro = TextEditingController();
  var txtBusto = TextEditingController();
  var txtCintura = TextEditingController();
  var txtQuadril = TextEditingController();
  var txtComprimento_do_corpo = TextEditingController();
  var txtBraco = TextEditingController();
  var txtPerna = TextEditingController();
  var txtCostas = TextEditingController();
  var txtCanela = TextEditingController();
  var txtValor = TextEditingController();
  bool cktecido_extra = false;
  bool ckbotoes_extra = false;
  bool ck_presente = false;
  String enviar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pedidos'), automaticallyImplyLeading: false,),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(40),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            OutlinedButton(
              child: Text('Menu'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 20),
            TextField(
              controller: txtPescoco,
              decoration: InputDecoration(
                hintText: 'Tamanho em centímetros',
                labelText: 'Pescoço',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: txtOmbro,
              decoration: InputDecoration(
                hintText: 'Tamanho em centímetros',
                labelText: 'Ombro',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: txtBusto,
              decoration: InputDecoration(
                hintText: 'Tamanho em centímetros',
                labelText: 'Busto',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: txtCintura,
              decoration: InputDecoration(
                hintText: 'Tamanho em centímetros',
                labelText: 'Cintura',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: txtQuadril,
              decoration: InputDecoration(
                hintText: 'Tamanho em centímetros',
                labelText: 'Quadril',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: txtComprimento_do_corpo,
              decoration: InputDecoration(
                hintText: 'Tamanho em centímetros',
                labelText: 'Comprimento do corpo',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: txtBraco,
              decoration: InputDecoration(
                hintText: 'Tamanho em centímetros',
                labelText: 'Braço',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: txtPerna,
              decoration: InputDecoration(
                hintText: 'Tamanho em centímetros',
                labelText: 'Perna',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: txtCostas,
              decoration: InputDecoration(
                hintText: 'Tamanho em centímetros',
                labelText: 'Costas',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: txtCanela,
              decoration: InputDecoration(
                hintText: 'Tamanho em centímetros',
                labelText: 'Canela',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            SizedBox(height: 10),
            
            CheckboxListTile(
              title: const Text('Para Presente'),
              value: ck_presente,
              onChanged: (bool value) {
                setState(() {
                  ck_presente = value;
                });
              },
              secondary: Icon(
                Icons.transfer_within_a_station,
                color: Colors.black,
              ),
              checkColor: Colors.pinkAccent,
              tileColor: Colors.pink[100],
              activeColor: Colors.black,
            ),
            CheckboxListTile(
              title: const Text('Tecido Extra'),
              value: ckbotoes_extra,
              onChanged: (bool value) {
                setState(() {
                  ckbotoes_extra = value;
                });
              },
              secondary: Icon(
                Icons.plus_one,
                color: Colors.black,
              ),
              checkColor: Colors.pinkAccent,
              tileColor: Colors.pink[100],
              activeColor: Colors.black,
            ),
            CheckboxListTile(
              title: const Text('Botões Extra'),
              value: cktecido_extra,
              onChanged: (bool value) {
                setState(() {
                  cktecido_extra = value;
                });
              },
              secondary: Icon(
                Icons.exposure_plus_1_outlined,
                color: Colors.black,
              ),
              checkColor: Colors.pinkAccent,
              tileColor: Colors.pink[100],
              activeColor: Colors.black,
            ),
            RadioListTile(
                title: Text("Enviar", style: TextStyle(color: Colors.black)),
                subtitle: Text("Sujeito a taxas",
                    style: TextStyle(color: Colors.black)),
                activeColor: Colors.pink[200],
                value: "D",
                groupValue: enviar,
                onChanged: (String valor) {
                  setState(() {
                    enviar = valor;
                  });
                }),
            RadioListTile(
                title: Text("Retirar no local",
                    style: TextStyle(color: Colors.black)),
                subtitle:
                    Text("Sem taxas", style: TextStyle(color: Colors.black)),
                activeColor: Colors.pink[200],
                value: "C",
                groupValue: enviar,
                onChanged: (String valor) {
                  setState(() {
                    enviar = valor;
                  });
                }),
            OutlinedButton(
              child: Text('VALOR'),
              onPressed: () {
                var msg = pedidoc (
                  txtPescoco.text,
                  txtOmbro.text,
                  txtBusto.text,
                  txtCintura.text,
                  txtQuadril.text,
                  txtComprimento_do_corpo.text,
                  txtBraco.text ,
                  txtPerna.text,
                  txtCostas.text,
                  txtCanela.text,
                  txtValor.text,
                );
                double valor1=double.parse(txtPescoco.text)*0.05;
                double valor2=double.parse(txtOmbro.text)*0.10;
                double valor3=double.parse(txtBusto.text)*0.05;
                double valor4=double.parse(txtCintura.text)*0.05;
                double valor5=double.parse(txtQuadril.text)*0.15;
                double valor6=double.parse(txtComprimento_do_corpo.text)*0.25;
                double valor7=double.parse(txtBraco.text)*0.05;
                double valor8=double.parse(txtPerna.text)*0.05;
                double valor9=double.parse(txtCostas.text)*0.1;
                double valor10=double.parse(txtCanela.text)*0.05;
                double total=valor1+valor2+valor3+valor4+valor5+valor6+valor7+valor8+valor9+valor10;
                msg.valor = total.toString();
                print(msg.pescoco.toString());
                Navigator.pushNamed(
                  context,
                  '/Carrinho',
                  arguments: msg
                );
              },
            ),
          ]),
        ),
      ),
    );
  }
}

//
//Tela do Carrinho - Victor
//
class Carrinho extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    pedidoc msg = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
       
        //Remover o ícone de Voltar
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      body:       
       SingleChildScrollView(
        child:
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(40),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                child: Text('PEDIDO'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          SizedBox(height: 40),
          Text('Pescoço',
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
              SizedBox(height: 10),
          Text(msg.pescoco, style: TextStyle(fontSize: 24)),
          SizedBox(height: 20),
          Text('Ombro',
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
              SizedBox(height: 10),
          Text(msg.ombro, style: TextStyle(fontSize: 24)),
          SizedBox(height: 20),
          Text('Busto',
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
              SizedBox(height: 10),
          Text(msg.busto, style: TextStyle(fontSize: 24)),
          SizedBox(height: 20),
          Text('Cintura',
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
              SizedBox(height: 10),
          Text(msg.cintura, style: TextStyle(fontSize: 24)),
          SizedBox(height: 20),
          Text('Quadril',
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
              SizedBox(height: 10),
          Text(msg.quadril, style: TextStyle(fontSize: 24)),
          SizedBox(height: 20),
          Text('Comprimento do corpo',
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
              SizedBox(height: 10),
          Text(msg.comprimento_do_corpo.toString(), style: TextStyle(fontSize: 24)),
          Text('Braço',
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
              SizedBox(height: 10),
          Text(msg.braco, style: TextStyle(fontSize: 24)),
          SizedBox(height: 20),
          Text('Perna',
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
              SizedBox(height: 10),
          Text(msg.perna, style: TextStyle(fontSize: 24)),
          SizedBox(height: 20),
          Text('Costas',
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
              SizedBox(height: 10),
          Text(msg.costas, style: TextStyle(fontSize: 24)),
          SizedBox(height: 20),
          Text('Canela',
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
              SizedBox(height: 10),
          Text(msg.canela, style: TextStyle(fontSize: 24)),
          SizedBox(height: 20),
          Text('VALOR TOTAL',
              style: TextStyle(fontSize: 40, fontStyle: FontStyle.italic)),
              SizedBox(height: 10),
          Text(msg.valor, style: TextStyle(fontSize: 35)),
        ]),
      )),
    );
  }
}

//
//Tela Sobre -Léo
//
class Sobre extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre'),centerTitle: true,

        //Remover o ícone de Voltar
        automaticallyImplyLeading: false,
        
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              OutlinedButton(
                child: Text('Voltar'),
                onPressed: () {

                  //Voltar para PrimeiraTela()
                  Navigator.pop(context, '/segunda');

                },
              ),
            ],
          ),
          SizedBox(height: 20),
          Text('Tema:', style: TextStyle(fontSize: 25, color: Colors.black)),
          SizedBox(height: 10),
          Text('Loja de Cosplay.', style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),),
          SizedBox(height: 20),
          Text('Objetivo:', style: TextStyle(fontSize: 25, color: Colors.black),),
          SizedBox(height: 10),
          Text('O aplicativo tem como objetivo simular a experiência de realizar uma encomenda para uma roupa do tipo "cosplay".', style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),),

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PerfilWidget('lib/images/Leonardo-editado.png', 'Leonardo Benelli Agostinho', '829.209'),
              PerfilWidget('lib/images/Victor.png', 'Victor Hugo Lopes da Silva Moro', '828.976'),
            ],
          ),
          ],
        ),
      ),
    );
  }
}
//
// Tela de Ajuda - Léo
//
class Ajuda extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajuda'),centerTitle: true,

        //Remover o ícone de Voltar
        automaticallyImplyLeading: false,
        
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              OutlinedButton(
                child: Text('Voltar'),
                onPressed: () {

                  //Voltar para PrimeiraTela()
                  Navigator.pop(context, '/segunda');

                },
              ),
            ],
          ),
           SizedBox(height: 20),
            Text('Por favor, entre em contato com o seguinte número:', style: TextStyle(fontSize: 25, color:Colors.black)),
            Text('+55(016)99129-1886', style: TextStyle(fontSize: 20, color:Colors.black)),
            Text('Disponível das 15:30 às 19:30', style: TextStyle(fontSize: 20, color:Colors.black)),
            Text('Segunda-feira à sexta-feira*', style: TextStyle(fontSize: 20, color:Colors.black)),
            SizedBox(height:10),
            Text('*Quarta-feira e final de semana não disponíveis', style: TextStyle(fontSize: 5, color:Colors.black)),
          ],
        )
      ),
    );
  }
}
//
// Tela de nova conta - Léo
//
class NovaConta extends StatefulWidget {
  @override
  _NovaContaState createState() => _NovaContaState();
}

class _NovaContaState extends State<NovaConta>{

  var txtBio = TextEditingController();
  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar conta'),centerTitle: true,

        //Remover o ícone de Voltar
        automaticallyImplyLeading: false,
        
      ),
      body: Container(
        padding: EdgeInsets.all(50),
        child: ListView(
          children: [
            TextField(
              controller: txtBio,
              style:
                  TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.w300),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person), labelText: 'Nome'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: txtEmail,
              style:
                  TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.w300),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email), labelText: 'E-mail'),
            ),
            SizedBox(height: 20),
            TextField(
              obscureText: true,
              controller: txtSenha,
              style:
                  TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.w300),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock), labelText: 'Senha'),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  child: OutlinedButton(
                    child: Text('Criar nova conta'),
                    onPressed: () {

                      criarConta(txtBio.text,txtEmail.text,txtSenha.text);
                    },
                  ),
                ),
                Container(
                  width: 150,
                  child: OutlinedButton(
                    child: Text('Cancelar'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  //
  // CRIAR CONTA no Firebase Auth - Léo
  //
  void criarConta(nome,email,senha){

    FirebaseAuth fa = FirebaseAuth.instance;

    fa.createUserWithEmailAndPassword(email: email, password: senha)
      .then((resultado){

        //armazenar dados da conta no Firestore
        var db = FirebaseFirestore.instance;
        db.collection('usuarios').doc(resultado.user.uid).set(
          {
            'Nome' : nome,
            'E-mail': email,
          }
        ).then((valor){
          ScaffoldMessenger.of(this.context).showSnackBar(
            SnackBar(
              content: Text('ユーザーが正常に作成されました。'),
              duration: Duration(seconds: 2),
            )
          );
          Navigator.pop(this.context);
        });

    }).catchError((erro){
      var errorCode = erro.code;
      print(errorCode);
      if(errorCode == 'email-already-in-use'){
        ScaffoldMessenger.of(this.context).showSnackBar(
          SnackBar(
            content: Text('入力したメールはすでに使用されています。'),
            duration: Duration(seconds: 2),
          )
        );
      }else{
        ScaffoldMessenger.of(this.context).showSnackBar(
            SnackBar(
              content: Text('エラー  ${erro.message}'),
              duration: Duration(seconds: 2),
            )
          );
      }
    });

  }
}
//
// Tela de Cadastro - Léo
//
class TelaCadastroBio extends StatefulWidget {
  @override
  _TelaCadastroBioState createState() => _TelaCadastroBioState();
}

class _TelaCadastroBioState extends State<TelaCadastroBio> {
  
  var txtBio = TextEditingController();

  //Recuperar um DOCUMENTO a partir do ID
  void getDocumentById(String id) async {
    await FirebaseFirestore.instance
        .collection('bio').doc(id).get()
        .then((value) {
          txtBio.text = value.data()['Biografia'];
    });
  }
  
   @override
  Widget build(BuildContext context) {
    //Recuperar o ID que foi passado como argumento
    var id = ModalRoute.of(context)?.settings.arguments;

    if (id != null) {
      if (txtBio.text == ''){getDocumentById(id.toString());}
    }
    return  Scaffold(
      appBar: AppBar(
          title: Text('Biografia'),
          centerTitle: true,
          backgroundColor: Colors.brown
      ),
      backgroundColor: Colors.brown[50],

      body: Container(
        padding: EdgeInsets.all(50),
        child: ListView(
          children: [

            TextField(
                  controller: txtBio, keyboardType: TextInputType.text, maxLines: 15, decoration: InputDecoration(labelText: 'Fale um pouco sobre você:', border: OutlineInputBorder(), alignLabelWithHint: true),
                ),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  child: OutlinedButton(
                    child: Text('Salvar'),
                    onPressed: (){

                      var db = FirebaseFirestore.instance;

                      if(id == null){
                        //Adicionar um novo documento
                        db.collection('bio').add({
                          "Biografia":txtBio.text,
                        });
                      }else{
                        //Atualizar um documento
                        db.collection('bio').doc(id.toString()).update({
                          "Biografia":txtBio.text,
                        });
                      }
                      Navigator.pop(context);
                    }
                  ),
                ),
                Container(
                  width: 150,
                  child: OutlinedButton(
                    child: Text('Cancelar'),
                    onPressed: (){
                      Navigator.pop(context);
                    }
                  ),
                ),
              ],
            )
          ]
        ),
      ),
    );
  }
}
//Usuário de Teste Leonardo e suas maquinações maliciosas e desesperadoras
//Senha de Teste SenhasuperlongaTipoIncrivelmentelongaquehackertempreguiçadeHackear