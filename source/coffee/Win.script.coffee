###
# Win.js
# @namespeace Win
#
# @version 0.1
# @author Jhon Marroquin || @jhon3rick
# @author Jonatan Herran || @jonatan2874
#
###

"use strict"

do ($W = Win) ->

	$W.Script = {}

	# ---------------------------------------------------------------------------
	# PUBLIC Methods
	# Script Win
	# ---------------------------------------------------------------------------

	###
	@method strReplace Reemplaza string en una cadena
	@param str cadena de texto
	@param str string a reemplazar
	@param str string que reemplaza
	@return str cadena con string reemplazados
	###
	$W.Script.strReplace = (cadena, buscada, reemplazo) ->	# REEMPLAZA TODAS LAS COICIDENCIAS DE LA PALABRA BUSCADA POR LA PALABRA EN REEMPLAZO
		while (cadena.toString().indexOf(buscada) != -1)
			cadena = cadena.toString().replace(buscada,reemplazo)
		cadena

	###
	@method dateNow
	@param int id_pais (49=>colombia)
	@param str valor numero de identificacion
	@return str numero de verificacion (DV)
	###
	$W.Script.numberTechnical = (id_pais,valor) ->
		dv = ''

		if id_pais is 49
			if !isNaN valor
				x = 0
				y = 0
				z = valor.length

				vpri = [16]
				vpri[1] = 3
				vpri[2] = 7
				vpri[3] = 13
				vpri[4] = 17
				vpri[5] = 19
				vpri[6] = 23
				vpri[7] = 29
				vpri[8] = 37
				vpri[9] = 41
				vpri[10] = 43
				vpri[11] = 47
				vpri[12] = 53
				vpri[13] = 59
				vpri[14] = 67
				vpri[15] = 71

				for i in z
					y  = valor.substr(i,1)
					x += y*vpri[z-i]
				y = x%11

				if y > 1 then dv=11-y
				else dv = y
		dv

	###
	@method dateNow
	@return str fecha en "yyyy-mm-dd"
	###
	$W.Script.dateNow = () ->
		day   = 0
		month = 0
		date  = new Date()
		year  = date.getFullYear()

		if (date.getMonth())+1 < 10 then month = "0"+(date.getMonth()+1)
		else month = date.getMonth()+1

		if date.getDate() < 10 then day = "0"+date.getDate()
		else day = date.getDate()

		year+"-"+month+"-"+day

	###
	@method timeMeridian
	@param str Hora en fortmato (00:00:00) 24Hrs
	@return str Hora en fortmato (00:00 AM/PM)
	###
	$W.Script.timeMeridian = (formato) ->
		if formato is null then formato = 'AM/PM'

		hr = new Date()
		H  = hr.getHours()
		M  = hr.getMinutes()

		if H<12 then A = "AM" else A = "PM"
		if M<10 then M = "0"+M

		if formato == 'AM/PM'
			if H>12 then H = H-12
			if H<10 then H = "0"+H
			HORA = H+":"+M+" "+A

		if formato == '24Hrs'
			if H<10 then H = "0"+H
			HORA = H+":"+M

		HORA

	###
	@method timeMysql
	@param str Hora en fortmato (00:00 AM) o (00:00)
	@return str Hora MYSQL(00:00:00)
	###
	$W.Script.timeMysql = (hora) ->
		A = hora.split(' ')

		if A.length==1 then H = "#{A[0]}:00"
		else if A.length==2
			B = A[0].split(':')
			if A[1] == 'PM' then B[0] = eval(B[0])+eval(12)
			H = "#{B[0]}:#{B[1]}:00"
		H

	###
	@method dateLong
	@param str Date en formato mysql "y-m-d"
	@return str Fecha larga
	###
	$W.Script.dateLong = (date) ->
		day     = ["Domingo","Lunes","Martes","Miercoles","Jueves","Viernes","Sabado"]
		month   = ["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"]
		NewDate = date.split("-")
		"#{NewDate[2]} #{month[NewDate[1]-1]} de #{NewDate[0]}"

	###
	@method numberFormat
	@param str Date en formato mysql "y-m-d"
	@return str Fecha larga
	###
	$W.Script.numberFormat = (number,decimals,dec_point,thousands_sep) ->
		n = number
		c = if isNaN(decimals = Math.abs(decimals)) then 2 else decimals
		d = if dec_point == undefined then "," else dec_point
		t = if thousands_sep == undefined then "." else thousands_sep
		s = if n < 0 then "-" else ""
		i = parseInt(n = Math.abs(+n || 0).toFixed(c)) + ""
		j = if (j = i.length) > 3 then j % 3 else 0
		return s +
				(if j then i.substr(0, j) + t else "") +
				i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) +
				(if c then d + Math.abs(n - i).toFixed(c).slice(2) else "")


	# ---------------------------------------------------------------------------
	# Static Methods
	# Public Elements
	# ---------------------------------------------------------------------------

