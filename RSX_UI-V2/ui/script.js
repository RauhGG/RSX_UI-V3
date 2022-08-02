$(() =>{
        $('#hunger').fadeOut(400)
        $('#thirst').fadeOut(400)
        $('#energy').fadeOut(400)
        $('#shield').fadeOut(400)
        $('#vels').fadeOut(400)
        $('.rangovoz').fadeOut(400)
        $('.radio').fadeOut(400)
        $('.freq').fadeOut(400)
    let iv = false;
    addEventListener('message', (event) => {
        let v = event.data;

        let he = Math.round(v.health)
        let h = Math.round(v.food)
        let t = Math.round(v.water)
        let s = v.stamina
        let e = v.shield
        $('#vida').text(he)
        $('#hambre').text(h)
        $('#sed').text(t)
        $('#stamina').text(s)
        $('#escudo').text(e)
        $('.calles').text(v.calles);

        if (h < 50) {
            $('#hunger').fadeIn(400)
        } else {
            $('#hunger').fadeOut(400)
        }
        if (t < 50) { 
            $('#thirst').fadeIn(400)
        } else {
            $('#thirst').fadeOut(400)
        }
        if (s < 0) {
            $('#energy').fadeIn(400)
        } else {
            $('#energy').fadeOut(400)
        }
        if (e > 0) {
            $('#shield').fadeIn(400)
        } else {
            $('#shield').fadeOut(400)
        }

        inveh(v.inveh)

        if (v.inveh) {
            $('#vels').fadeIn(400)
            $('.kmh').text(Math.round(v.speed))
        } else {
            $('#vels').fadeOut(400)
        }
        if (v.temp < 50) {
            $('.temp').css('border-bottom', 'yellow solid .2vw')
        }
         if (v.temp < 30) {
            $('.temp').css('border-bottom', 'orange solid .2vw')
        }
        if (v.temp < 10) {
            $('.temp').css('border-bottom', 'red solid .2vw')
        }
        if (v.temp > 50) {
            $('.temp').css('border-bottom', 'black solid .2vw')
        }

        $('.gas-lvl').text(' ' + Math.round(v.gas) + ' L')

        if (v.sbl) {
            $('.sbelt').css('border-bottom', 'rgb(0, 255, 42) solid .2vw')
        } else {
            $('.sbelt').css('border-bottom', 'rgb(0, 0, 0) solid .2vw')
        }



        if (v.istalking) {
            $('.maicrofon').css({'box-shadow' : '0vw 0vw 0vw .2vw #fff', 'transform' : 'scale(.9)'});
        } else {
            $('.maicrofon').css({'box-shadow' : '0vw 0vw 0vw 0vw #fff', 'transform' : 'scale(1)'});
        }

        if (v.showrange == 'trigger') {
            $('.rangovoz').text(v.range)
            $('.rangovoz').fadeIn(400)
            setTimeout(() => {
                $('.rangovoz').fadeOut(400)
            }, 1000)
        }

        if (v.radio) {
            $('.radio').fadeIn(400)
            $('.freq').fadeIn(400)
            $('.maicrofon').css('bottom', '5.7vw')
            $('.rangovoz').css('bottom', '5.7vw')
            $('.freq').text(v.radiochan + ' MHz')
        } else {
            $('.radio').fadeOut(400)
            $('.freq').fadeOut(400)
            $('.maicrofon').css('bottom', '3vw')
            $('.rangovoz').css('bottom', '3vw')
        }

        if (v.talkingradio) {
            console.log('talking radio')
            $('.maicrofon').css({'box-shadow' : '0vw 0vw 0vw 0vw #fff', 'transform' : 'scale(1)'});
            $('.radio').css({'box-shadow' : '0vw 0vw 0vw .2vw #fff', 'transform' : 'scale(.9)'});
        } else {
            $('.radio').css({'box-shadow' : '0vw 0vw 0vw 0vw #fff', 'transform' : 'scale(1)'});
        }

    });

    function inveh(bool) {
        if (bool) {
            if (!iv) {
                $('#container').animate({left : '+=15vw'}, 400)
                iv = true;
            }
        } else {
            if (iv) {
                $('#container').animate({left : '-=15vw'}, 400)
                iv = false;
            }
        }
    }
})