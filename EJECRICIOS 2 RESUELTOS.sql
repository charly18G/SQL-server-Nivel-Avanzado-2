
--1.

select tdv.NombreDocumento, dv.NumeroDocumento,dv.FechaDocumento, dv.Ruc, dv.NombreCliente, m.Simbolo,
	case when m.Simbolo = 'US$'
		then dv.Total
		else 0
		end as 'Importe Dolares',
	case when m.Simbolo = 'S/.'
		then dv.Total
		else 0
		end as 'Importe Soles'
from DocumentoVenta as dv
join moneda as m
 on m.CodigoMoneda= dv.CodigoMoneda
join tipoDocumentoVenta as tdv
 on tdv.CodigoTipoDocumento=dv.CodigoTipoDocumento
-- Acá realicé un group by para asegurarme que no hay registros repetidos; sin embargo, no es necesario
group by tdv.NombreDocumento, dv.NumeroDocumento,dv.FechaDocumento, dv.Ruc, dv.NombreCliente, m.Simbolo, dv.NumeroDocumento, dv.Total


--2. 

select tdv.NombreDocumento, dv.NumeroDocumento,dv.FechaDocumento, dv.Ruc, dv.NombreCliente, m.Simbolo,
	case when m.Simbolo = 'US$'
		then dv.Total
		else 0
		end as 'Importe Dolares',
	case when dv.Total > 5000
		then 'SI'
		else 'NO'
		end as 'Mayor a 5000'
from DocumentoVenta as dv
join moneda as m
 on m.CodigoMoneda= dv.CodigoMoneda
join tipoDocumentoVenta as tdv
 on tdv.CodigoTipoDocumento=dv.CodigoTipoDocumento
 where m.Simbolo = 'US$'
-- No es necesario el group by ni el order by. Solo es para comprobar el código sea correcto
group by tdv.NombreDocumento, dv.NumeroDocumento,dv.FechaDocumento, dv.Ruc, dv.NombreCliente, m.Simbolo, dv.NumeroDocumento, dv.Total
order by dv.Total

--3. 

select tdv.NombreDocumento, dv.NumeroDocumento,dv.FechaDocumento, dv.Ruc, dv.NombreCliente, m.Simbolo,
	case when m.Simbolo = 'US$'
		then dv.Total
		else 0
		end as 'Importe Dolares',
	case when dv.Total > 5000
		then 'MAYOR'
		else case when dv.Total = 5000
				then 'IGUAL'
				else 'MENOR'
				end 
		end as 'Comparacion a 5000'
from DocumentoVenta as dv
join moneda as m
 on m.CodigoMoneda= dv.CodigoMoneda
join tipoDocumentoVenta as tdv
 on tdv.CodigoTipoDocumento=dv.CodigoTipoDocumento
 where m.Simbolo = 'US$'
-- De la misma manera que en el ejercicio anterior, no es necesario el group by y el order by para estos casos 
group by tdv.NombreDocumento, dv.NumeroDocumento,dv.FechaDocumento, dv.Ruc, dv.NombreCliente, m.Simbolo, dv.NumeroDocumento, dv.Total
order by dv.Total

--4.

select case when CodigoTipoDocumento= '01'
			then 'Factura'
			else case when CodigoTipoDocumento= '03'
					  then 'Boleta'
					  else case when codigotipodocumento= '07'
								then 'N/CREDITO'
								else case when codigotipodocumento= '08'
										  then 'N/DEBITO'
										  else case when codigotipodocumento= '07'
													then 'Recibo de Cobranza'
													else 'Recibo de Caja'
													end
										  end
								 end
						end
			  end as 'TipoDocumento',
-- NOTA: para cada case when, es necesario que se cierre con un 'end'; así el programa entenderá que se ha querido cerrar un proceso abierto.
-- En caso no lo hagan, les saltará un error sobre escritura de código.
NumeroDocumento, FechaDocumento, Ruc, NombreCliente
from DocumentoVenta

--5. 

select tdv.NombreDocumento, dv.NumeroDocumento, dv.FechaDocumento, dv.Ruc, dv.NombreCliente, 
	case when dv.CodigoMoneda= 'PEN'
		 then dv.Total
		 else (dv.Total/tc.tc_venta)
		 end as 'Importe Soles',
	tc.tc_venta as 'Tipo Cambio'
from DocumentoVenta as dv
join tipo_cambio as tc
 on dv.FechaDocumento= tc.fechaTipoCambio
join tipoDocumentoVenta as tdv
 on tdv.CodigoTipoDocumento= dv.CodigoTipoDocumento
 where dv.FechaDocumento like '%2014%'
 order by dv.FechaDocumento

--6.

select tdv.NombreDocumento as 'TipoDocumento', dv.Ruc, dv. NombreCliente, m.Simbolo,
 	case when m.Simbolo = 'US$'
		then dv.Total
		else 0
		end as 'Importe Dolares',
	case when m.Simbolo = 'S/.'
		then dv.Total
		else 0
		end as 'Importe Soles'
 from DocumentoVenta as dv
 join moneda as m
  on m.CodigoMoneda= dv.CodigoMoneda
 join tipoDocumentoVenta as tdv
 on tdv.CodigoTipoDocumento= dv.CodigoTipoDocumento
 group by tdv.NombreDocumento, dv.NumeroDocumento, dv.FechaDocumento, dv.Ruc, dv.NombreCliente, m.Simbolo, dv.Total
 order by dv.NombreCliente

 --7.

select dv.ruc, dv.NombreCliente,
 case when dv.CodigoMoneda= 'PEN'
		 then dv.Total
		 else (dv.Total/tc.tc_venta)
		 end as 'Importe Soles'
 from DocumentoVenta as dv
 join tipo_cambio as tc
  on tc.fechaTipoCambio= dv.FechaDocumento
  where dv.FechaDocumento like '%2014%'
  group by NombreCliente
order by CodigoCliente





