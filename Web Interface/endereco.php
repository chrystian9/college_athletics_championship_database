<?php
header("Content-Type: text/html; charset=utf8",true);
?>
<html>
<head><title>Endereço Torneio: <?php echo $_GET['nome']; ?>.</title></head>
<body>
  <center>
    <h3>Endereço Completo do Torneio: <?php echo $_GET['nome']; ?></h3>
  </center>

  <table border="0" align="center" width="">
    <?php
      include("./config.php");
      $con = mysqli_connect($host, $login, $senha, $bd);
      $sql = "SELECT cidade, estado, logradouro, numero, complemento, bairro,referencia, CEP  FROM torneio WHERE nome = '".$_GET['nome']."'";
      $tabela = mysqli_query($con, $sql);
      if(mysqli_num_rows($tabela)==0){
    ?>
        <tr><td align="center">Não Existe Torneio de nome <?php echo $_GET['nome']; ?></td></tr>
        <tr><td align="center"><input type="button" value="Voltar" onclick="location.href='index.php'"></td></tr>
    <?php
      }else{
        $dados = mysqli_fetch_row($tabela);
    ?>
    	<tr bgcolor="grey">
        <th>Cidade</th>
        <th>Estado</th><!--VOLTAR AQUI -->
        <th>Logradouro</th>
        <th>Numero</th>
        <?php if(!is_null($dados[4])) {echo "<th>Complemento</th>";} ?>
        <th>Bairro</th>
        <?php if(!is_null($dados[6])) {echo "<th>Referencia</th>";} ?>
        <th>CEP</th>
      </tr>

      <tr>
        <td><?php echo $dados[0]; ?></td>
        <td><?php echo $dados[1]; ?></td>
        <td><?php echo $dados[2]; ?></td>
        <td><?php echo $dados[3]; ?></td>
        <?php if(!is_null($dados[4])) {echo "<td>".$dados[4]."</td>";} ?>
        <td><?php echo $dados[5]; ?></td>
        <?php if(!is_null($dados[6])) {echo "<td>".$dados[6]."</td>";} ?>
        <td><?php echo $dados[7]; ?></td>
      </tr>

    <tr bgcolor="grey"><td colspan="8" height="5"></td></tr>
    <?php
    mysqli_close($con);
    ?>
    <tr><td colspan="8" align="center"><input type="button" value="Voltar" onclick="location.href='index.php'"></td></tr>
    <?php
    }
    ?>
  </table>

</body>
</html>
