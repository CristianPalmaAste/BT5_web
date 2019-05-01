select perf.descripcion
      ,prog.titulo
from   perf
      ,pepr
      ,prog
where  perf.id     = pepr.idperf
and    pepr.idprog = prog.id
and    perf.id     in (1,2,20,21)
order  by 1
         ,2
;

\q
