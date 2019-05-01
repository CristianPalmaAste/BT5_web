<?php
   class FormColumn {
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
			   
			   if ($value!="")
				  $s .=" value='$value'";
			   
			   if ($readonly)
				  $s .=" readonly";
			   else if ($onblur!="") {
				  $s .= " onblur='".$onblur."();'";
			   }
			  
			   $s .= "/>";
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
   }//FormColumn

   class oForm{
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
		
		 $this->cols[] = new FormColumn($props);
		 //print_r($this->cols);
		 
	  }
	  
      function show() {
		 $s = "";
		 
		 foreach($this->cols as $c) {
			$gadget   = $c("gadget",   "text");
		    $type     = $c("type",     "C");
		    $name     = $c("name",     "NONAME");
			$caption  = $c("caption",  $name);
		    $id       = $c("id",       $name);
		    $readonly = $c("readonly", false);		 
		    $nRow     = $c("nRow",     "");
		    $value    = $c("value",    "");
		    $onblur   = $c("onblur",   "");
			
			$fld      = $c->show();
		 }
		 
		 return $s;
	  }
	  
   }//oForm