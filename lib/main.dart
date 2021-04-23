import 'package:dark_candy/Galeria.dart';
import 'package:flutter/material.dart';
import 'package:dark_candy/PerfilDev.dart';

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
      '/Perfil': (context) => Perfil(),
      '/Galeria': (context) => Galeria(),
      '/Pedido': (context) => Pedido(),
      '/Carrinho': (context) => Carrinho(),
      '/Sobre': (context) => Sobre(),
      '/Ajuda': (context) => Ajuda(),
      '/Parte de cima': (context) => PartCima(),
      '/Parte de baixo': (context) => PartBaixo(),
      '/Sapatos': (context) => Sapatos(),
    },
  ));
}

class Mensagem{
  final String login;
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
          var msg = Mensagem (
                txtLogin.text,
              );
          Navigator.pushNamed(context, '/segunda', arguments: msg);
        },
      ),
    );
  }
}

//
// MENU PRINCIPAL - Victor
//
class MenuPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Receber o objeto da classe Mensagem
    Mensagem msg = ModalRoute.of(context).settings.arguments;
    if (msg == null){
      msg = Mensagem('');
    }
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

            Text('Seja bem vindo(a), '+msg.login+'.', style: TextStyle(fontSize: 15, color:Colors.black)),
            SizedBox(height: 10),

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
                Navigator.pushNamed(context, '/Perfil', arguments: msg);
              },
              hoverColor: Colors.indigo[100],

            ),

            ListTile(
              leading: Icon(Icons.arrow_forward, color: Colors.pink[400]),
              trailing: Icon(Icons.photo_library, color: Colors.indigo[700]),
              title: Text('GALERIA', style: TextStyle(fontSize: 32, color:Colors.black)),
              
              onTap: (){
                print('item pressionado');
                Navigator.pushNamed(context, '/Galeria');
              },
              hoverColor: Colors.indigo[100],
            ),

            ListTile(
              leading: Icon(Icons.arrow_forward, color: Colors.pink[400]),
              trailing: Icon(Icons.content_cut,color: Colors.indigo[700]),
              title: Text('PEDIDO', style: TextStyle(fontSize: 32, color:Colors.black)),
              
              onTap: (){
                print('item pressionado');
                Navigator.pushNamed(context, '/Pedido');
              },
              hoverColor: Colors.indigo[100],
            ),

            /*ListTile(
              leading: Icon(Icons.arrow_forward, color: Colors.pink[400]),
              trailing: Icon(Icons.shopping_cart, color: Colors.indigo[700]),
              title: Text('CARRINHO', style: TextStyle(fontSize: 32, color:Colors.black)),
              
              onTap: (){
                print('item pressionado');
                Navigator.pushNamed(context, '/Carrinho');
              },
              hoverColor: Colors.indigo[100],
            ),*/ //removido por falta de razão dele estar aqui.

            ListTile(
              leading: Icon(Icons.arrow_forward, color: Colors.pink[400]),
              trailing: Icon(Icons.bookmark_border, color: Colors.indigo[700]),
              title: Text('SOBRE', style: TextStyle(fontSize: 32, color:Colors.black)),
              
              onTap: (){
                print('item pressionado');
                Navigator.pushNamed(context, '/Sobre');
              },
              hoverColor: Colors.indigo[100],
            ),

            ListTile(
              leading: Icon(Icons.arrow_forward, color: Colors.pink[400]),
              trailing: Icon(Icons.accessibility, color: Colors.indigo[700]),
              title: Text('AJUDA', style: TextStyle(fontSize: 32, color:Colors.black)),
              
              onTap: (){
                print('item pressionado');
                Navigator.pushNamed(context, '/Ajuda');
              },
              hoverColor: Colors.indigo[100],
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
class Perfil extends StatelessWidget{
  
  final txtBio = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Mensagem msg = ModalRoute.of(context).settings.arguments;
    if (msg == null){
      msg = Mensagem('');
    }
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.supervised_user_circle, color: Colors.white, size: 300),
                Text(msg.login, style: TextStyle(fontSize: 25, color:Colors.black)),
                SizedBox(height: 40),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Biografia:', style: TextStyle(fontSize: 25, color: Colors.black)),
                SizedBox(height: 10),
                TextField(
                  controller: txtBio, keyboardType: TextInputType.text, maxLines: 15, decoration: InputDecoration(labelText: 'Fale um pouco sobre você:', border: OutlineInputBorder(), alignLabelWithHint: true),
                )
              ],
            )
        ]),
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
              hoverColor: Colors.indigo[100],
            ),
            SizedBox(height: 5),
            ListTile(
              leading: Icon(Icons.arrow_forward, color: Colors.pink[400]),
              title: Text('Parte de baixo', style: TextStyle(fontSize: 32, color:Colors.black)),
              
              onTap: (){
                print('item pressionado');
                Navigator.pushNamed(context, '/Parte de baixo');
              },
              hoverColor: Colors.indigo[100],
            ),
            SizedBox(height: 5),
            ListTile(
              leading: Icon(Icons.arrow_forward, color: Colors.pink[400]),
              title: Text('Sapatos', style: TextStyle(fontSize: 32, color:Colors.black)),
              
              onTap: (){
                print('item pressionado');
                Navigator.pushNamed(context, '/Sapatos');
              },
              hoverColor: Colors.indigo[100],
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
                  Navigator.pop(context, '/segunda');

                },
              ),
            ],
          ),
          SizedBox(height: 20),
            GaleriaWidget(''),
            GaleriaWidget(''),
            GaleriaWidget(''),
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
                  Navigator.pop(context, '/segunda');

                },
              ),
            ],
          ),
          SizedBox(height: 20),
            GaleriaWidget(''),
            GaleriaWidget(''),
            GaleriaWidget(''),
          ],
        ),
      )
    );
  }
}
class Sapatos extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Sapatos'),centerTitle: true,

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
                  Navigator.pop(context, '/segunda');

                },
              ),
            ],
          ),
          SizedBox(height: 20),
            GaleriaWidget(''),
            GaleriaWidget(''),
            GaleriaWidget(''),
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
                hintText: 'Tamanho em Milimetros',
                labelText: 'Pescoço',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: txtOmbro,
              decoration: InputDecoration(
                hintText: 'Tamanho em Milimetros',
                labelText: 'Ombro',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: txtBusto,
              decoration: InputDecoration(
                hintText: 'Tamanho em Milimetros',
                labelText: 'Busto',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: txtCintura,
              decoration: InputDecoration(
                hintText: 'Tamanho em Milimetros',
                labelText: 'Cintura',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: txtQuadril,
              decoration: InputDecoration(
                hintText: 'Tamanho em Milimetros',
                labelText: 'Quadril',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: txtComprimento_do_corpo,
              decoration: InputDecoration(
                hintText: 'Tamanho em Milimetros',
                labelText: 'Comprimento do corpo',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: txtBraco,
              decoration: InputDecoration(
                hintText: 'Tamanho em Milimetros',
                labelText: 'Braço',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: txtPerna,
              decoration: InputDecoration(
                hintText: 'Tamanho em Milimetros',
                labelText: 'Perna',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: txtCostas,
              decoration: InputDecoration(
                hintText: 'Tamanho em Milimetros',
                labelText: 'Costas',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: txtCanela,
              decoration: InputDecoration(
                hintText: 'Tamanho em Milimetros',
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
              checkColor: Colors.deepPurple[100],
              tileColor: Colors.indigo[100],
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
              checkColor: Colors.deepPurple[100],
              tileColor: Colors.indigo[100],
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
              checkColor: Colors.deepPurple[100],
              tileColor: Colors.indigo[100],
              activeColor: Colors.black,
            ),
            RadioListTile(
                title: Text("Enviar", style: TextStyle(color: Colors.black)),
                subtitle: Text("Sujeito a taxas",
                    style: TextStyle(color: Colors.black)),
                activeColor: Colors.blue[400],
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
                activeColor: Colors.blue[400],
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

class Ajuda extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre'),centerTitle: true,

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
//Usuário de Teste Leonardo e suas maquinações maliciosas e desesperadoras
//Senha de Teste SenhasuperlongaTipoIncrivelmentelongaquehackertempreguiçadeHackear