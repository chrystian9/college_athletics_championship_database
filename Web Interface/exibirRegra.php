<?php
header("Content-Type: text/html; charset=utf8",true);
?>
<html>
<head><title>Regra Torneio: <?php echo $_GET['nome']; ?>.</title></head>
<body>
  <?php
    include("./config.php");
    $con = mysqli_connect($host, $login, $senha, $bd);
    $sql = "SELECT regras FROM torneio WHERE nome = '".$_GET['nome']."'";
    $tabela = mysqli_query($con, $sql);
    mysqli_close($con);
    if(mysqli_num_rows($tabela)==0){
  ?>
    <table border="0" align="center" width="">
      <tr><td align="center">Não Existe Torneio de nome <?php echo $_GET['nome']; ?></td></tr>
      <tr><td align="center"><input type="button" value="Voltar" onclick="location.href='index.php'"></td></tr>
    </table>
  <?php
    } else {
      $dados = mysqli_fetch_row($tabela);
  ?>
      <object data="data:application/pdf;base64,<?php echo base64_encode($dados[0]);?>" type="application/pdf" height="100%" width="100%"></object>
  <?php
    }
  ?>

</body>
</html>
