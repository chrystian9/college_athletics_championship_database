<?php
header("Content-Type: text/html; charset=utf8",true);
?>
<html>
<head><title>Torneios Intertléticas.</title></head>
<body>
  <center>
    <h3>Torneios Intertléticas.</h3>
  </center>
  <form name="form1" method="POST" action="form_incluir.php">
    <table border="0" align="center" width="">
      <?php
        include("./config.php");
        $con = mysqli_connect($host, $login, $senha, $bd);
        $sql = "SELECT * FROM torneio ORDER BY data";
        $tabela = mysqli_query($con, $sql);
        if(mysqli_num_rows($tabela)==0){
      ?>
        <tr><td align="center">Sem torneios cadastrados no banco</td></tr>
        <tr><td align="center"><input type="submit" value="Inserir Torneio"></td></tr>
      <?php
        }else{
      ?>
      	<tr bgcolor="grey">
          <th>Nome</th>
          <th>Descricao</th><!--VOLTAR AQUI -->
          <th>Regras</th>
          <th>Local</th>
          <th>Data</th>
          <th></th>
        </tr>
      <?php
        while($dados = mysqli_fetch_row($tabela)){
          $date = new DateTime($dados[1]);
          $dados[1] = $date->format('d-m-Y');
      ?>
        <tr>
          <td><?php echo $dados[0]; ?></td>
          <td><?php echo $dados[2]; ?></td>
          <td><a href="exibirRegra.php?nome=<?php echo $dados[0]; ?>">Visualizar Regras</a></td>
          <td><a href="endereco.php?nome=<?php echo $dados[0]; ?>"><?php echo $dados[6]." - ".$dados[7]; ?></a></td>
          <td><?php echo $dados[1]; ?></td>
      	  <td align="center">
      	    <input type="button" value="Excluir" onclick="location.href='excluir.php?codigo=<?php echo $dados[0]; ?>'">
      	    <input type="button" value="Editar" onclick="location.href='form_incluir.php?codigo=<?php echo $dados[0]; ?>'">
      	  </td>
        </tr>
      <?php
        }
      ?>
      <tr bgcolor="grey"><td colspan="6" height="5"></td></tr>
      <?php
      mysqli_close($con);
      ?>
      <tr><td colspan="6" align="center"><input type="submit" value="Incluir Novo Torneio"></td></tr>
      <?php
      }
      ?>
    </table>
  </form>
</body>
</html>
