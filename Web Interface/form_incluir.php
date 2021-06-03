<?php
header("Content-Type: text/html; charset=utf8",true);
?>
<html>
<head><title>Incluir/Editar um Torneio.</title></head>
<body>
  <form name="form1" method="POST" action="incluir.php" enctype="multipart/form-data">
    <?php
    if(isset($_GET["codigo"])){
      include("./config.php");
      $con = mysqli_connect($host, $login, $senha, $bd);
    ?>
      <center><h3>Editar Torneio</h3></center>
    <?php
      $sql = "SELECT * FROM torneio WHERE nome='".$_GET['codigo']."'";
      $result = mysqli_query($con, $sql);
      $vetor = mysqli_fetch_array($result, MYSQLI_ASSOC);
      mysqli_close($con);
      $date = new DateTime($vetor['data']);
      $vetor['data'] = $date->format('d-m-Y');
    ?>
      <input type="hidden" name="codigo" value="<?php echo $_GET['codigo']; ?>">
    <?php
    }else{
    ?>
      <center><h3>Cadastrar Novo Torneio</h3></center>
    <?php
    }
    ?>
    <table border="0" align="center" width="35%">
      <tr>
          <td width="20%">Nome:</td>
          <td colspan="2" width="90%">
      	     <input type="text" name="nome" value="<?php echo @$vetor['nome']; ?>" maxlength="50" size="31">
      	  </td>
      </tr>
      <tr>
          <td>Data:</td>
          <td >
              <input type="text" name="data" value="<?php echo @$vetor['data']; ?>" size="3">
          </td>
      </tr>
      <tr>
          <td>Descrição:</td>
          <td colspan="2" width="90%">
            <textarea id="descricao" name="descricao" rows="4" cols="41" style="resize: none;">
                <?php echo @$vetor['descricao']; ?>
            </textarea>

          </td>
      </tr>
      <tr>
          <td>Regras:</td>
          <td colspan="2" width="90%">
              <input type="file" name="regras" maxlength="2" size="3">
          </td>
      </tr>
      <tr>
          <th colspan="3" align="center"><br>Endereço:</th>
      </tr>
      <tr>
          <td width="20%">Cidade:</td>
          <td colspan="2" width="90%">
      	     <input type="text" name="cidade" value="<?php echo @$vetor['cidade']; ?>" maxlength="50" size="31">
      	  </td>
      </tr>
      <tr>

          <td width="20%">Estado:</td>
          <td colspan="2" width="90%">
      	     <input type="text" name="estado" value="<?php echo @$vetor['estado']; ?>" maxlength="50" size="31">
      	  </td>
      </tr>
      <tr>
          <td width="20%">Logradouro:</td>
          <td colspan="2" width="90%">
      	     <input type="text" name="logradouro" value="<?php echo @$vetor['logradouro']; ?>" maxlength="50" size="31">
      	  </td>
      </tr>
      <tr>
          <td width="20%">Numero:</td>
          <td colspan="2" width="90%">
      	     <input type="text" name="numero" value="<?php echo @$vetor['numero']; ?>" maxlength="50" size="31">
      	  </td>
      </tr>
      <tr>
          <td width="20%">Complemento:</td>
          <td colspan="2" width="90%">
      	     <input type="text" name="complemento" value="<?php echo @$vetor['complemento']; ?>" maxlength="50" size="31">
      	  </td>
      </tr>
      <tr>
          <td width="20%">Bairro:</td>
          <td colspan="2" width="90%">
      	     <input type="text" name="bairro" value="<?php echo @$vetor['bairro']; ?>" maxlength="50" size="31">
      	  </td>
      </tr>
      <tr>
          <td width="20%">Referencia:</td>
          <td colspan="2" width="90%">
      	     <input type="text" name="referencia" value="<?php echo @$vetor['referencia']; ?>" maxlength="50" size="31">
      	  </td>
      </tr>
      <tr>
          <td width="20%">CEP:</td>
          <td colspan="2" width="90%">
      	     <input type="text" name="CEP" value="<?php echo @$vetor['CEP']; ?>" maxlength="50" size="31">
      	  </td>
      </tr>

      <tr><td colspan="3" align="center">
            <input type="button" value="Cancelar" onclick="location.href='index.php'">
            <input type="submit" value="Gravar">
          </td>
      </tr>
    </table>
  </form>
</body>
</html>
