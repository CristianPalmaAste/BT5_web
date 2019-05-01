<?php
 
 
 class Item {
      public $name="NONAME";
      public $id="";
      public $type="C";
      public $len=10;
      public $dec=0;
      public $req="N";
      public $pk="N";
      public $gadget="text";
      public $caption="NOCAPTION";
      public $size=10;
      public $maxlength="";
      public $rows=5;
      public $cols=60;
      public $readonly="N";
      public $value="";
      public $selValues=array();	
      public $before="<tr><td>";
      public $middle="</td><td>";
      public $after ="</td></tr>";  
      public $default="";
	  public $virtual="N";
	  public $tbl_sel="";
	  public $fld_sel="";
	  public $filter_sel="";
      
      public function show() {
	     $s = "";
	     
	     $f = $this;
      
         if ($f->caption=="")
            $f->caption=$f->name;
            
         if ($f->req=="Y")
            $f->caption .="*";
            
         if ($f->id=="") $f->id = $f->name;
            
         switch($f->gadget) {
            case "text":
               
               if ($f->maxlength=="") $f->maxlength = $f->size;
               
               $s = "<input type='text' id='$f->id' name='$f->name'";

               if ($i->value!="")
                  $s .= " value='$f->value'";

               $s .= " size='$f->size' maxlength='$f->maxlength'";
               
               if ($f->req=="Y")      $s .= ' required';
               
               if ($f->readonly=="Y") $s .= ' readonly';
			   
			   if ($f->type=="I" || $f->type=="N") 
				   $s .= " style='text-align:right;color:black;'";
			   else
				   $s .= " style='color:black;'";
               
               $s .= "/>";
               break;
               
            case "textarea":
               
               $s = "<textarea id='$f->id' name='$f->name' value='$f->value' rows='$f->rows' cols='$f->cols'";
               
               if ($f->req=="Y")      $s .= ' required';
               
               if ($f->readonly=="Y") $s .= ' readonly';
               
               $s .= ">$f->value</textarea>";
               break;  
               
            case "select":
               $s = "<select id='$f->id' name='$f->name' style='color:black;'>";
			   $s .= "<option value=''>Seleccione</option>\n";
               foreach($f->selValues as $key => $val)
                  $s .= "<option value='$key'>$val</option>\n";
               $s .= "</select>\n";
               break;        
               
            case "hidden":
               $s = "<input type='hidden' id='$f->id' name='$f->name' value='$f->value'/>";
               break;    
         }
         
         return $s;
      }
  }
  
  class Block {
	 public $name="NONAME";
	 public $tabname="";
	 public $where="";
	 public $order="";
	 public $struct=array();
	 public $items=array();
	 public $isgrid=false;
	 public $conn;
	 
	 public function __construct($conn, $name, $tabname="") {
		$this->name=$name;
		$this->tabname=$tabname;
		$this->conn = $conn;
		
		$this->fillStructure();
	 }
	 
	 public function fillStructure() {		 
	    include_once("trad.php");
		
		$sql = "select * from information_schema.columns ".
		       "where  table_name='$this->name' ".
			   "order by ordinal_position";
			   
	    //echo $sql."<br/>";		   
		
        $stmt = $this->conn->execute($sql);

        $rows = $stmt ->fetchAll('assoc');
		
		//echo "Voy a mostrar trad<br/>";
		
		//print_r($_trad);

        // Associative array
        foreach($rows as $r) {
	       $i = new Item();
		   $i->gadget  = "text";
	       $i->name    = $r["column_name"];
	       $i->caption = ucfirst(strtolower($row["column_name"]));	       
	       $i->req     = $r["is_nullable"]=="NO"?"Y":"N";
	       $i->pk      = $r["column_name"]=="id"?"Y":"N";
		   
		   if ($i->pk=="Y") $i->gadget="hidden";
		   
		   if (isset($_trad[$i->name])) $i->caption = $_trad[$i->name];
		   
		   $nomostrar=[ "idusuacrearegistro"	
                       ,"fechacrearegistro"	
                       ,"idusuamodifregistro"	
                       ,"fechamodifregistro"	
                       ,"idusuaborraregistro"	
                       ,"fechaborraregistro"	
					   ,"idempr"
					   ,"idgrem"
                      ];
					  
		   if (in_array($i->name, $nomostrar))
			  $i->gadget="hidden";
		   
		   $data_type  = $r["data_type"];
	       
		   switch($data_type) {
			  case "character varying": $i->type = "C"; 
			                            $i->len=$r["character_maximum_length"];
										$i->size=$i->len;
										break;
			  case "timestamp widthout zone":   $i->type="D";
	                                            $i->len=10;
	                                            $i->size=10;
			                                    break;
			  case "numeric": $i->type = "N";
			                  $i->len  = $r["numeric_precision"];
							  
							  if ($i->len > 10)
								 $i->size = 10;
							  else
							     $i->size = $i->len;
							  break;
		   }
		   
		   //if ($i->len > 120) $i->gadget = "textarea";
 
           
           $this->items[] = $i;
        }
	 }
	 
	 public function show() {
		$lista="";
		$s = "";
		foreach($this->items as $i) {
		   if ($i->gadget=="hidden")
		      $lista .= $i->show()."\n";
		   else { 
		      $fld = $i->show();
		   
		      $s .= $i->before.$i->caption.$i->middle.$fld.$i->after."\n";
	       }
		}
		
		$s.= "\n$lista";
		
		return $s;		
	 }
	 
	 public function showGrid() {
		$s = "<tr>\n";
		$s.= "<td colspan='2' align='center'><table border='1'>\n";
	    foreach($this->items as $i) {
		   if ($i->gadget!="hidden") 
		      $s .= "<td align='center'>$i->caption</td>\n";
	    }
	    for ($n=0; $n < 5; $n++) {
		   $lista="";
		   $s.= "<tr>\n";
		   foreach($this->items as $i) {
			  $i->name .= $n;
			  $i->id   .= $n;
			   
			  if ($i->gadget=="hidden")
		         $lista .= $i->show()."\n";
		      else {
		         $fld = $i->show();
		   
		         $s .= "<td>$fld</td>\n";
	          } 
	          
		   }
		   $s.= "</tr>\n";
		   $s.= "\n$lista";
	    }
	    
	    $s.="</table></td>\n";	    	    
	    $s.="</tr>\n";
		
		return $s;
	 }
	 
	 public function fetch($fldname) {
	    foreach($this->items as $i)
	       if ($i->name==$fldname)
	          return $i;
	          
	    return null;	 
	 }
	 
	 public function genLayout() {
		$nomostrar=[ "idusuacrearegistro"	
                       ,"fechacrearegistro"	
                       ,"idusuamodifregistro"	
                       ,"fechamodifregistro"	
                       ,"idusuaborraregistro"	
                       ,"fechaborraregistro"	
                      ];
					  
		$lista="";
		$s = "<table>\n";
		foreach($this->items as $i) 
		   if (!in_array($i->name, $nomostrar)) {
		      if ($i->gadget=="hidden")
		         $lista .= "{".$i->name."}"."\n";
		      else {
		         $fld = $i->show();
		      
		         $s .= $i->before."{caption.".$i->name."}".$i->middle."{".$i->name."}".$i->after."\n";
	          }
		   }
		
		$s.="</table>\n";
		$s.= "\n$lista";
		
		return $s;		
	 }
	 
	 public function addItem($i) {
		$this->items[] = $i;
	 }
	 
  }
  
  class Form {
	 public $caption="NOTITLE";
     public $blocks=array();
     
     public function __construct($caption) {
	    $this->caption=$caption;
     }
     
     public function addBlock($b) {
	    $this->blocks[] = $b;
     }
     
     public function show() {
	    //$s = "<form id='frm' name='frm' method='post'>\n";
	    $s = "<h3>$this->caption</h3>\n";
	    $s.= "<table style='border:1px solid white;'>\n";
	    foreach($this->blocks as $b)
	       if ($b->isgrid)
	          $s .= $b->showGrid();
	       else
	          $s .= $b->show();
	       
	    $s.= "<tr><td colspan='2' align='right'><button style='color:black;'>Enviar</button></td></tr>\n";
	    
	    $s.= "</table>\n";
	    //$s.= "</form>\n";
	    
	    return $s; 
     }
	 
	 public function showLayout($layout) {
		//echo "showLayout<br/>"; 
		$archivo =  APP . 'Layouts' . DS . $layout . ".lay";
		
		$archivo = str_replace('\\', '/', $archivo);
		
		if (!is_file($archivo))
		   throw New \Exception("No encontré el archivo: '$archivo'!\n");
		
		$lines=file($archivo); 
		
		$s = "";
		foreach($lines as $line)
		   $s .= $line;
		   
		foreach($this->blocks as $b) 
		   foreach($b->items as $i)  {
			  $caption = $i->caption;
			  
			  if ($i->req=="Y")
                 $caption .="*";
			 
			  if ($i->gadget=="select" && $i->tbl_sel!="") {
				 $sql = "select * from ".$i->tbl_sel;
				 
				 if ($i->filter_sel != "")
					$sql .=" where ".$i->filter_sel;
				
				 $sql .= " order by ".$i->fld_sel; 
				 
				 
				 
	             //echo $sql."<br/>";		   
		
                 $stmt = $b->conn->execute($sql);

                 $rows = $stmt ->fetchAll('assoc'); 
				 $sel = [];
				 
				 foreach($rows as $r) 
				    $sel[$r["id"]] = $r[$i->fld_sel];
					
			     $i->selValues = $sel;		
				 
				 
              }
		
			  $fld     = $i->show();
			  $name    = $i->name;
			  
			  $s = str_replace('{caption.'.$name.'}', $caption, $s);
			  $s = str_replace('{'.$name.'}', $fld, $s);			  
		   }
		      
		   
		return $s;
	 }
     
  }