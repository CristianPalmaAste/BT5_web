<?php
   //Clase GridRow
   class GridRow {
      public $props=[];
	  
	  public function __construct($props) {
		 $this->props = $props; 
      }
	  
	  public function getProp($pName, $vdefault="") {
	     if (isset($this->props[$pName]))
		    return $this->props[$pName];
	     else
		    return $vdefault;
	  }
	  
	  public function show() {
	     $gadget   = $this->getProp("gadget",   "text");
		 $type     = $this->getProp("type",     "C");
		 $name     = $this->getProp("name",     "NONAME");
		 $id       = $this->getProp("id",       $name);
		 $readonly = $this->getProp("readonly", false);		 
		 $nRow     = $this->getProp("nRow",     "");
		 $value    = $this->getProp("value",    "");
		 $onblur   = $this->getProp("onblur",   "");
		 
		 $class    = $this->getProp("class",   "");
		 
		 
		 
		 //print_r($this->props); echo "<hr/>";
		 //$name .= $nRow;
		 $id   .= $nRow;
		 
		 $s = "";
		 switch($gadget) {
		    case "text":
			   $size      = $this->getProp("size", 10);
			   $maxlength = $this->getProp("maxlength", 10);
			   
			   $s .= "<input type='text' id='$id' name='$name' size='$size' maxlength='$maxlength'";
			   
			   if ($type=="I" || $type=="N") {
				  if ($readonly)
					 $s .= " style='color:black;text-align:right;'";  
				  else
				     $s .= " style='color:black;text-align:right;'"; 
			   }	  
			   else
			      $s .= " style='color:black;'";
			   
			   $s .=" class='upper';";
			   
			   if ($value!="")
				  $s .=" value='$value'";
			   
			   if ($readonly)
				  $s .=" readonly";
			   else if ($onblur!="") {
				  $s .= " onblur='".$onblur."();'";
			   }
			  
			   $s .= "/>";
			   break;
			
			case "select": 
			     $selvalues  = $this->getProp("selvalues", []);
				 
				 //print_r($selvalues);
				 
			     $s .= "<select id='$id' name='$name' style='color:black;'>\n";
				 
				 foreach($selvalues as $key => $val)
				    $s .= "<option value='$key'>$val</option>\n";
					
				 $s .= "</select>\n";
			   break;
			   
			case "button":
			   $caption = $this->getProp("caption", $name);
               $s .= "<input type='button' id='$id' name='$name' value='$caption' class='btn btn-info btn-sm' style='height:30px'/>";
               break;	
			   
			case "link":
			   $caption = $this->getProp("caption", $name);
               $s .= "<a href='#' >$caption</a>";
               break;	
			   
			case "hidden":
               $s .= "<input type='hidden' id='$id' name='$name' value='$value'/>";
               break;			   
		 }
		 
		 return $s;
	  } 
	  
	  public function showVal() {
	     $gadget   = $this->getProp("gadget",   "text");
		 $type     = $this->getProp("type",     "C");
		 $name     = $this->getProp("name",     "NONAME");
		 $id       = $this->getProp("id",       $name);
		 $readonly = $this->getProp("readonly", false);		 
		 $nRow     = $this->getProp("nRow",     "");
		 $value    = $this->getProp("value",    "");
		 $onblur   = $this->getProp("onblur",   "");
		 
		 $s = $value==""?"&nbsp;":$value;
		 
		 return $s;
		 
	 }	 
   }

   //Clase Grid
   class Grid {
      public $cols=[];
	  public $rows=[];
	  public $nRow=0;
	  public $readonly=false;
	  
	  public function __construct($rows) {	 
		 $this->rows=$rows;
	  }
	  
	  function addCol($props=array()) {
		 if ($this->readonly)
            $props["readonly"] = true;
		
		 $this->cols[] = new GridRow($props);
		 //print_r($this->cols);
		 
	  }
	  
	  public function showHeader() {
		 $s = "<tr>\n";
		 //$s .= "<td>&nbsp;</td>\n";
		 foreach($this->cols as $c) {
			$caption = $c->getProp("caption", "NOCAPTION");
			$gadget  = $c->getProp("gadget",  "text");
			
			if ($gadget!="hidden")
			   $s.= "<th>$caption</th>\n";
		 }
		 
		 $s .= "<td></td>";
         $s .= "</tr>\n";

         return $s;		 
	  }
	  
	  public function preShowField($name, $r, $rows) {
		 return $r;
	  }
	  
	  public function showRow($i, $hidden=false) {
		 $ss = "<tr>\n";		
		 //$ss .= "<td style='border: 1px white;'>$i</td>\n";	
		 		 
		 $lista="";	 
		 
		 $data="";
		 
		 foreach($this->cols as $r) {	
            $name = $r->getProp("name", "NONAME");
			$valor= $this->rows[$i][$name];			
			
			if ($i < count($this->rows)) {	
               if (isset($this->rows[$i][$name])) {			
			      $r->props["value"] = $this->rows[$i][$name];			
			      $r = $this->preShowField($name, $r, $this->rows[$i]);
			   }
			}
			else {
			   $r->props["value"] = "";	
		   
			   $r = $this->preShowField($name, $r, []);
			}

			if ($this->readonly) $r->props["readonly"] = true;	
				
            $fld = $r->show();
			
			$gadget = $r->getProp("gadget", "text");
			//$valor  = $r->getProp("value",  "");
			$type   = $r->getProp("type",   "C");
			
			//if ($data!="") $data .= "|";
			
			$data .= "|".$valor;
			
			if ($gadget=="hidden")
			   $lista .= $fld;
		    else {
			   if ($type=="N" || $type=="I")
				  $align=" align='right'";
			   else
				  $align="";
			  
			   if ($this->readonly) {
				  $ss .= "<td$align>".$valor."</td>\n"; 
			   }
			   else {
				  if ($gadget=="select") {
					 $name  = $r->getProp("name", "NONAME");
					 
					 $encontrado=false;
					 foreach($this->cols as $c) {	
                        $nombre = $c->getProp("name", "NONAME");
						
						if ($name."2"==$nombre) {
						   $valor = $c->getProp("value", "");
						   $encontrado=true;
						   break;
						}
					 }
					 
					 if ($encontrado) 					 					 					 					
					    $ss .= "<td$align>".$valor."</td>\n"; 					 
					 else {
					
						$selvalues  = $r->getProp("selvalues", []);
						
						if (isset($selvalues[$valor]))
						   $ss .= "<td$align>".$selvalues[$valor]."</td>\n"; 	
					    else						
						   $ss .= "<td$align>".$valor."</td>\n"; 
					 }
				  }
                  else					  
			         $ss .= "<td$align>".$valor."</td>\n";
			   }
			}
		 }
		 
		 $k = $i + 2;
		 
		 $data = substr($data, 1);
		 $sdata = "<input type='hidden' id='data".$k."' value='".$data."'/>";
		 
		 if ($this->readonly)
			$botones="<td class='fondoCelda'>&nbsp;$sdata</td>";
		 else {
		 $botones = "<td class='fondoCelda'><input type='button' value='Edit' onclick='javascript:editar(".$k.")' class='btn btn-default'/>&nbsp;".
		 "<input type='button' value='Del' onclick='javascript:eliminar(".$k.")' class='btn btn-default'/>$sdata</td>";
         }
		 
		 $ss .= $lista."$botones</tr>\n";
		 
		 return $ss;
	  }
	  	  
	  public function showEditor() {
		 $ss = "<tr>\n";		
		 //$ss .= "<td style='border: 1px white;'>$i</td>\n";	
		 		 
		 $lista="";	 
		 foreach($this->cols as $r) {	
            $name = $r->getProp("name", "NONAME");
			
		    //$r->props["nRow"]=$i;
			
			
			   //echo $name."<hr>";
			   $r->props["value"] = "";	
			
			   
			   $r = $this->preShowField($name, $r, []);
			

			if ($this->readonly)
			   $r->props["readonly"] = true;
		   
            $fld = $r->show();
			
			$gadget = $r->getProp("gadget", "text");
			
			
			if ($gadget=="hidden") {
			   $r->props["readonly"] = true;	
			   $lista .= $fld;
			}
		    else
			   $ss .= "<td>".$fld."</td>\n";
		 }
		 
		 $ss .= $lista."<td><div id='b_ins' style='float:left;padding-right:5px;'><input type='button' value='Aceptar' id='btnOk' class='btn btn-default'/></div><div style='float:left;'><input type='button' id='btnCancel' value='Cancelar' class='btn'/></div></td></tr>\n";
		 
		 return $ss;
	  }
	  
	  
	  function showRows() {		 
	     if (!$this->readonly)
	        $s = $this->showEditor();
		 else
			$s = "";
		 
		 $this->nRow=0;
		 
		 if (count($this->rows)==0) {
			$allRows = isset($_REQUEST["allRows"])?$_REQUEST["allRows"]:"";
			
			if ($allRows!="") {
    			
    			$filas = explode("@@@", $allRows);
    			
    	        foreach($filas as $data) {
    		       $e = explode("|", $data);
    			   
    			   $n = 0;
    			   $r = [];
    			   
    			   foreach($this->cols as $c) {
    			      $name = $c->getProp("name", "NONAME");
    				  
    				  $r[$name] = $e[$n];
    				  
    				  $n++;
    			   }
    			   
    			   $this->rows[] = $r;
    			}			
			}
		 }
		 
         for ($i=0; $i < count($this->rows); $i++) {
  			$this->nRow = $i; 
  		    $s .= $this->showRow($i);
         }		
         				
		 return $s;
	  }
	  
	  function showFooter() {
		 return "";
	  }
	  
	  function show() {
		 //if (!$this->readonly)
		 //   $this->addCol(["name" => "btnDel", "caption" => "Elim",  "gadget" => "link"]);  
		
		 return "<table id='mitabla' border='1' style='border:1px solid white;'>\n".
		        $this->showHeader().
				$this->showRows().
				$this->showFooter().
				"</table>";
	  } 
	  
	  public function genGridJs() {
		$layout="";
		
		if ($this->readonly)
		   $lineas=file("gridview.lay");	
		else
		   $lineas=file("grid.lay");
        
        foreach($lineas as $linea) 
           $layout .= $linea;

        $inicializa="";
		$firstField="";
        $setea_variables="";
		$data="";
		$valores_td="";
		$mueve_a_inputs_e="";
		$n=0;
		$inicializa_con_es="";
		$req_fields="";
		
		$max_len=0;
		
		foreach($this->cols as $c) {
		   	$name = $c->getProp("name", "NONAME");
			
			if (strlen($name) > $max_len) $max_len = strlen($name);
		}
		
		$sum_cols = array();
		
        foreach($this->cols as $c) {
		   	$name     = $c->getProp("name",     "NONAME");
			$gadget   = $c->getProp("gadget",   "text");
			$type     = $c->getProp("type",     "C");
			$sum      = $c->getProp("sum",      "");
			$required = $c->getProp("required", false);
			$selvalues  = $c->getProp("selvalues", []);
			$value    = $c->getProp("value",    "");
			$field    = $name;
			
			if ($required) {
			   $req_fields .= "\n   if (document.getElementById('$name')==null || document.getElementById('$name').value==\"\") {\n".
			                  "      alert('¡Debe ingresar un valor en este campo!');\n".
							  "      document.getElementById('$name').focus();\n".
							  "      return false;\n".
			                  "   }\n";  
			}
						
			if ($sum!="") {
			   $s = explode(",", $sum);
			   
			   foreach($s as $ss)
			      if (!in_array($ss, $sum_cols))
			         $sum_cols[] = $ss;
			}
			
			//$name = str_pad($name, $max_len);
			
		   if ($firstField=="") $firstField=$name;
		   
		   $inicializa .= "document.getElementById('".$name."').value='';\n";
		   
		   if ($data!="") $data .= "+\"|\"+";
		   
		   
		   $setea_variables .= str_pad($name, $max_len)."=document.getElementById('".$name."').value;\n";
		   $data .= $name;
		   		   
		   
		   if ($gadget!="hidden") {
			  if ($type=="N" || $type=="I")
				 $align=" align='right'";
			  else
				 $align="";
			 
			  
			  if ($gadget=="select") { 
			     $setea_variables .= "v = document.getElementById('$field').value;\n";
			     $setea_variables .= "l = document.getElementById('$field');\n";
				 $setea_variables .= "for (i=0; i < l.length; i++) {\n".
				                     "   if (l.options[i].value==v) {\n".
									 "      l$field = l.options[i].text;\n".
									 "      break;\n".
                                     "   }\n".								 
				                     "}\n";
				
				 
				 $valores_td .= "		                 \"<td class='fondoCelda'$align>\"+$field+\"</td>\"+\n";
		      }
	          else
 		         $valores_td .= "		                 \"<td class='fondoCelda'$align>\"+$name+\"</td>\"+\n";
			  
		   }
		   
		   $mueve_a_inputs_e .="		 document.getElementById(\"$name\"       ).value = e[$n];\n";
		   
		   $inicializa_con_es .= "			".str_pad($name, $max_len)." = e[$n];\n";
		   
		   $n++;		   
        }
		
		$ini_sums="";
		$sums_a_totales="";
		foreach($sum_cols as $sum) {
		   $ini_sums .= "       $sum = 0;\n";		  

		   $s = explode(",", $sum);

           foreach($s as $ss)		
              $sums_a_totales .= "      document.getElementById('$ss').value = $ss*1.0;\n"; 		   
		}
		
		$actualiza_sums="";
		foreach($this->cols as $c) {
		   	$name   = $c->getProp("name",   "NONAME");
			$gadget = $c->getProp("gadget", "text");
			$type   = $c->getProp("type",   "C");
			$sum    = $c->getProp("sum",    "");
			
			
			
			if ($sum!="") {
			   $s = explode(",", $sum);

               foreach($s as $ss)			   
			      $actualiza_sums .= "      $ss = $ss*1.0 + $name*1.0;\n";
			}
		}
		
		$layout = str_replace('{{inicializa}}',        $inicializa       , $layout);
		$layout = str_replace('{{firstField}}',        $firstField       , $layout);
        $layout = str_replace('{{setea_variables}}',   $setea_variables  , $layout);
		$layout = str_replace('{{data}}',              $data             , $layout);
		$layout = str_replace('{{valores_td}}',        $valores_td       , $layout);
		$layout = str_replace('{{mueve_a_inputs_e}}',  $mueve_a_inputs_e , $layout);
		$layout = str_replace('{{inicializa_con_es}}', $inicializa_con_es, $layout);
		$layout = str_replace('{{ini_sums}}'         , $ini_sums         , $layout);
		$layout = str_replace('{{actualiza_sums}}'   , $actualiza_sums   , $layout);
		$layout = str_replace('{{sums_a_totales}}'   , $sums_a_totales   , $layout);
		$layout = str_replace('{{req_fields}}'       , $req_fields       , $layout);
				
		return $layout;
	 }
	  
   }