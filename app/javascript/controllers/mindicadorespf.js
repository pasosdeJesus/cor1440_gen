export default class Cor1440Gen__Mindicadorespf {
  // MEDICIÓN DE INDICADORES

  static llenarMedicion(res) {
    let hid = res.hmindicadorpf_id
    $('[id=mindicadorpf_pmindicadorpf_attributes_' + hid + '_fecha]').
      val(res.fechaloc)
    let cont = 0
    res.datosint.forEach((v) => {
      $('[id$=_' + hid + '_datointermedioti_pmindicadorpf_attributes_' + 
        cont + '_valor]').val(v.valor)
      $('[id$=_' + hid + '_datointermedioti_pmindicadorpf_attributes_' + 
        cont + '_rutaevidencia]').val(v.rutaevidencia)
      cont++
    })
    $('[id=mindicadorpf_pmindicadorpf_attributes_' + hid + '_resind]').
      val(res.resind)
    $('[id=mindicadorpf_pmindicadorpf_attributes_' + hid + '_rutaevidencia]').
      val(res.rutaevidencia)
    let meta = +$('[id=mindicadorpf_pmindicadorpf_attributes_' + 
      hid + '_meta]').val()
    if ( meta > 0) {
      $('[id=mindicadorpf_pmindicadorpf_attributes_' + hid + '_porcump]').val(res.resind*100/meta)
    }
    let enlace = $('[id=mindicadorpf_pmindicadorpf_attributes_' + 
      hid + '_resind]').closest('td').find('a.enlaceevidencia')
    enlace.html(res.resind)
    enlace.attr('href', res.rutaevidencia)
  }


  static calcularPMIndicadorPF(elem, event) {
    event.stopPropagation() 
    event.preventDefault() 
    let r = $(elem).closest('tr')
    let efinicio = r.find('[id$=finicio]')
    let hid = efinicio.attr('id').replace(/.*_attributes_([0-9]*)_finicio/, '$1');
    let datos = {
      finicio: efinicio.val(),
      ffin: r.find('[id$=ffin]').val(),
      indicadorpf_id: $(document).find('#mindicadorpf_indicadorpf_id').val(),
      hmindicadorpf_id: hid,
      mindicadorpf_id: $('form.edit_mindicadorpf')[0].id.split('_')[2]
    }
    Msip__Motor.recibirJsonAjax('api/cor1440gen/medir_indicador', 
      datos, Cor1440Gen__Mindicadorespf.llenarMedicion)  
  }


  static preparar() {
    return true
    $("#cor1440_gen_mfun").hide();
    $(".cor1440_gen_funcion").bind("contextmenu", (e) => {
      window.cor1440_gen_mfun_enlace = e.target
      $("#cor1440_gen_mfun").css({
        'display':'block', 
        'left':e.pageX, 
        'top':e.pageY 
      });
      return false;
    })

    $(document).click( (e) => {
      if (e.button == 0) {
        $(".cor1440_gen_menucontextual").css("display", "none");
      }
    })

    $(document).keydown( (e) => {
      if (e.keyCode == 27) {
        $(".cor1440_gen_menucontextual").css("display", "none");
      }
    })

    $("#cor1440_gen_mfun").click((e) => {
      Msip_Motor.arreglarPuntomontaje()
      t = Date.now()
      d = -1
      if (window.cor1440_gen_mcarc_t) {
        d = (t - window.cor1440_gen_mcarc_t)/1000
      }
      // NO se permite mas de un envio en 2 segundos 
      if (d == -1 || d > 2) {
        window.cor1440_gen_mcarc_t = t
        switch (e.target.id) {
          case "actividades":
            window.cor1440_gen_mfun_enlace.value =
              "cuenta(Actividades_contribuyentes)"
            break;
          case "poblacion": 
            window.cor1440_gen_mfun_enlace.value =
              'suma(mapeaproy(Actividades_contribuyentes, poblacion))'
            break;
          case "asistentes": 
            window.cor1440_gen_mfun_enlace.value =
              'cuenta(aplana(mapeaproy(Actividades_contribuyentes, Asistentes)))'
            break
          case "asistentesunicos":
            window.cor1440_gen_mfun_enlace.value='cuenta(unicos(mapeaproy(aplana(mapeaproy(Actividades_contribuyentes, Asistentes)), persona)))'
            break
          case "organizaciones":
            window.cor1440_gen_mfun_enlace.value="cuenta(aplana(mapeaproy(Actividades_contribuyentes, Organizaciones)))"
            break
          case "organizacionesunicas":
            window.cor1440_gen_mfun_enlace.value="cuenta(unicas(aplana(mapeaproy(Actividades_contribuyentes, Organizaciones))))"
            break
        }
        $(".cor1440_gen_menucontextual").css("display", "none")
        return false
      }
    })
  }

}


