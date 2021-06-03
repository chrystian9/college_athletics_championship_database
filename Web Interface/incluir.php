<?php
  include("./config.php");
  $con = mysqli_connect($host, $login, $senha, $bd);
  $date = new DateTime($_POST['data']);
  $dataT = $date->format('Y-m-d');
  $regras = addslashes(file_get_contents($_FILES["regras"]["tmp_name"]));
  if(isset($_POST["codigo"])){
    $sql = "SELECT nome FROM torneio WHERE nome='".$_POST["codigo"]."'";
    $result = mysqli_query($con, $sql);
    if(mysqli_num_rows($result)!=0){
      if($_POST["complemento"] == "" && $_POST["referencia"] == ""){
        $sql = "UPDATE torneio SET nome='".$_POST["nome"]."',data='".$dataT."',descricao='".$_POST["descricao"]
        ."',regras='".$regras
        ."',cidade='".$_POST["cidade"]."',estado='".$_POST["estado"]."',logradouro='".$_POST["logradouro"]
        ."',numero='".$_POST["numero"]."',complemento=NULL"
        .",bairro='".$_POST["bairro"]."',referencia=NULL".",CEP='".$_POST["CEP"]."' WHERE nome='".$_POST["codigo"]."'";
      } else if($_POST["referencia"] == ""){
        $sql = "UPDATE torneio SET nome='".$_POST["nome"]."',data='".$dataT."',descricao='".$_POST["descricao"]
        ."',regras='".$regras
        ."',cidade='".$_POST["cidade"]."',estado='".$_POST["estado"]."',logradouro='".$_POST["logradouro"]
        ."',numero='".$_POST["numero"]."',complemento='".$_POST["complemento"]
        ."',bairro='".$_POST["bairro"]."',referencia=NULL".",CEP='".$_POST["CEP"]."' WHERE nome='".$_POST["codigo"]."'";
      } else if($_POST["complemento"] == ""){
        $sql = "UPDATE torneio SET nome='".$_POST["nome"]."',data='".$dataT."',descricao='".$_POST["descricao"]
        ."',regras='".$regras
        ."',cidade='".$_POST["cidade"]."',estado='".$_POST["estado"]."',logradouro='".$_POST["logradouro"]
        ."',numero='".$_POST["numero"]."',complemento=NULL"
        .",bairro='".$_POST["bairro"]."',referencia='".$_POST["referencia"]."',CEP='".$_POST["CEP"]."' WHERE nome='".$_POST["codigo"]."'";
      } else {
        $sql = "UPDATE torneio SET nome='".$_POST["nome"]."',data='".$dataT."',descricao='".$_POST["descricao"]
        ."',regras='".$regras
        ."',cidade='".$_POST["cidade"]."',estado='".$_POST["estado"]."',logradouro='".$_POST["logradouro"]
        ."',numero='".$_POST["numero"]."',complemento='".$_POST["complemento"]
        ."',bairro='".$_POST["bairro"]."',referencia='".$_POST["referencia"]."',CEP='".$_POST["CEP"]."' WHERE nome='".$_POST["codigo"]."'";
      }

    }
  }else{
    if($_POST["complemento"] == "" && $_POST["referencia"] == ""){
      $sql = "INSERT INTO torneio VALUES ('".$_POST["nome"]."','".$dataT."','".$_POST["descricao"]."','".$regras."'
      ,'".$_POST["logradouro"]."','".$_POST["CEP"]."','".$_POST["cidade"]."','".$_POST["estado"]."',NULL,'".$_POST["numero"]."'
      ,NULL,'".$_POST["bairro"]."')";
    } else if($_POST["referencia"] == ""){
      $sql = "INSERT INTO torneio VALUES ('".$_POST["nome"]."','".$dataT."','".$_POST["descricao"]."','".$regras."'
      ,'".$_POST["logradouro"]."','".$_POST["CEP"]."','".$_POST["cidade"]."','".$_POST["estado"]."','".$_POST["complemento"]."','".$_POST["numero"]."'
      ,NULL,'".$_POST["bairro"]."')";
    } else if($_POST["complemento"] == ""){
      $sql = "INSERT INTO torneio VALUES ('".$_POST["nome"]."','".$dataT."','".$_POST["descricao"]."','".$regras."'
      ,'".$_POST["logradouro"]."','".$_POST["CEP"]."','".$_POST["cidade"]."','".$_POST["estado"]."',NULL,'".$_POST["numero"]."'
      ,'".$_POST["referencia"]."','".$_POST["bairro"]."')";
    } else {
      $sql = "INSERT INTO torneio VALUES ('".$_POST["nome"]."','".$dataT."','".$_POST["descricao"]."','".$regras."'
      ,'".$_POST["logradouro"]."','".$_POST["CEP"]."','".$_POST["cidade"]."','".$_POST["estado"]."','".$_POST["complemento"]."','".$_POST["numero"]."'
      ,'".$_POST["referencia"]."','".$_POST["bairro"]."')";
    }
  }
  $res = mysqli_query($con, $sql);
  mysqli_close($con);
  header("location: ./index.php");
?>
