//
// Classe do Usuário - Léo
//
class Usuario{
    String id;
    String email;
    String nome;

    Usuario(this.id, this.email,this.nome);

    Usuario.fromJson(Map<String,dynamic> map, String id){
      this.id = id;
      this.email = map['E-mail'];
      this.nome = map['Nome'];
    }

    Map<String, dynamic> toJson(){
      final Map<String, dynamic> map = Map<String, dynamic>();
      map['id'] = this.id;
      map['E-mail'] = this.email;
      map['Nome'] = this.nome;
      return map;
    }
  }