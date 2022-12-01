<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="keywords" content="">
  <meta name="description" content="">

  <title>Restaurant</title>

  <!-- Loading Bootstrap -->
  <link href="static/css/bootstrap.css" rel="stylesheet">

  <!-- Loading Template CSS -->
  <link href="static/css/style.css" rel="stylesheet">
  <link href="static/css/animate.css" rel="stylesheet">
  <link href="static/css/style-magnific-popup.css" rel="stylesheet">

  <!-- Fonts -->
  <link href="static/css/font-awesome.min.css" rel="stylesheet">
  <link href="static/css/icons-main.css" rel="stylesheet">
  <link href="static/css/icons-helper.css" rel="stylesheet">

  <!-- RS5.0 Main Stylesheet -->
  <link rel="stylesheet" type="text/css" href="static/css/settings.css">

  <!-- RS5.0 Layers and Navigation Styles -->
  <link rel="stylesheet" type="text/css" href="static/css/layers.css">
  <link rel="stylesheet" type="text/css" href="static/css/navigation.css">

  <!-- Google Fonts -->
  <link href='static/css/css.css' rel='stylesheet' type='text/css'>
  <link href='static/css/css1.css' rel='stylesheet' type='text/css'>
  <link href='static/css/css2.css' rel='stylesheet' type='text/css'>

  <!-- Font Favicon -->


  <!-- HTML5 shim, for IE6-8 support of HTML5 elements. All other JS at the end of file. -->
  <!--[if lt IE 9]>
  <script src="js/html5shiv.js"></script>
  <script src="js/respond.min.js"></script>
  <![endif]-->

  <!--headerIncludes-->

</head>
<body>

<!--begin header -->
<header class="header">

  <!--begin nav -->
  <nav class="navbar navbar-default navbar-fixed-top">

    <!--begin container -->
    <div class="container">

      <!--begin navbar -->
      <div class="navbar-header">
        <button data-target="#navbar-collapse-02" data-toggle="collapse" class="navbar-toggle" type="button">
          <span class="sr-only">Toggle navigation</span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>

        <a href="index.html" class="navbar-brand brand scrool"><img src="static/picture/logo.png"
                                                                    alt="logo"></a>
      </div>

      <div id="navbar-collapse-02" class="collapse navbar-collapse">
        <ul class="nav navbar-nav navbar-right">
          <li><a href="index.html">Home</a></li>
          <li><a href="about.html">About Us</a></li>
          <li><a href="readDish">Menu</a></li>
          <li><a href="order.html">Dishes Order</a></li> <!--跳转到以点订单-->
          <li><a href="gallery.html">Gallery</a></li>
          <li><a href="contact.html">Contact</a></li>
          <li class="social"><a href="#" class="first"><i class="fa fa-twitter"></i></a></li>
          <li class="social"><a href="#"><i class="fa fa-facebook"></i></a></li>
          <li class="social"><a href="#" class="last"><i class="fa fa-instagram"></i></a></li>
          <li><a href="openTable.jsp" class="purchase">OPEN A TABLE</a></li> <!--开台-->
        </ul>
      </div>
      <!--end navbar -->

    </div>
    <!--end container -->

  </nav>
  <!--end nav -->

</header>
<!--end header -->

<!--begin reservation-hero-section -->
<section id="hero-section" class="reservation-hero-section">

  <!--begin image-overlay -->
  <div class="image-overlay"></div>
  <!--end image-overlay -->

  <!--begin container-->
  <div class="container image-section-inside">

    <!--begin row-->
    <div class="row">

      <!--begin col-md-6-->
      <div class="col-md-6 text-center register-inner padding-top-30">

        <span class="comic-text">Start Your Food Trip</span>

        <h2 style="color:#ffffff">OPEN A TABLE</h2>

        <p style="color:#ffffff">Curabitur quas nets lacus ets nulat iaculis loremis etis nisle varius vitae
          seditum fugiatum ligula aliquam qui sequi. Lorem ipsum dolor sit amet, consectetur adipiscing elit
          rutrum eleif arcu sit aspernatur nets fugit, sed quia.</p>

        <!--begin success message -->
        <p class="register_success_box" style="display:none;color:#ffffff" id="result">Successfully opened! your seat
          number is </p>
        <!--end success message -->

        <!--begin register form -->
        <form id="register-form" class="contact" onsubmit="f1()">

          <!--begin col-md-6-->
          <div class="col-md-6">

            <input class="register-input-2 white-input" required="" name="register_names"
                   placeholder="Full Name" type="text" id="fullName">


            <select class="register-input-2 white-input" required="" name="register_ticket" id="number">
              <option value="">How Many?</option>
              <option value=1>1 Person</option>
              <option value=2>2 People</option>
              <option value=3>3 People</option>
              <option value=4">4 People</option>
              <option value=5>5 People</option>
              <option value=6>6 People</option>
              <option value=7>7 People</option>
              <option value=8>8 People</option>
              <option value=9>9 People</option>
              <option value=10>10 People</option>
            </select>

            <script type="text/javascript">
              function f1() {
                let number = document.getElementById("number").value;
                let phoneNumber = document.getElementById("phoneNumber").value;
                let fullName = document.getElementById("fullName").value;
                console.log(number + ":" + phoneNumber + ":" + fullName);
                axios.get('/openTable?number=' + number + "&phoneNumber" + phoneNumber + "&fullName" + fullName //向后端传数据
                ).then(res => {
                  console.log(res.data);
                  let seat = res.data; // 获取后端返回数据
                  let result = document.getElementById("result");
                  result.innerText = result.innerText + seat;
                  console.log(seat);
                }).catch(err => {
                  console.log(err);
                });
              }
            </script>


            <div id="show_seatNum"></div>

            <%--<p style="color:#ffffff">
              Please chose your seat number:
              <input class="register-input-2 white-input" required="" name="register_names"
                     placeholder="Optional seat number: 1/3/10/16/22" type="text">
            </p>--%>

            <%--<c:if test="${seat}!=null">

            </c:if>--%>

          </div>
          <!--end col-md-6-->

          <!--begin col-md-6-->
          <div class="col-md-6">

            <input class="register-input-2 white-input" required="" name="register_phone"
                   placeholder="Phone Number" type="text" id="phoneNumber">

          </div>
          <!--end col-md-6-->

          <!--begin col-md-12-->
          <div class="col-md-12">

            <input value="Open Your Table" id="submit-button" class="register-submit" type="submit">

          </div>
          <!--end col-md-12-->

        </form>
        <!--end register form -->

      </div>
      <!--end col-md-6-->

      <!--begin col-md-6-->
      <div class="col-md-6 wow bounceInUp">
        <img src="static/picture/a10.jpg" alt="picture" class="width-100">
      </div>
      <!--end col-md-6-->
    </div>
    <!--end row-->

  </div>
  <!--end container-->

</section>
<!--end reservation-hero-section -->

<!--begin section-white-->
<section class="section-white small-padding no-padding-bottom">

  <!--begin container-->
  <div class="container">

  </div>
  <!--end container-->

</section>
<!--end section-white-->

<!-- begin revolution slider -->
<div id="rev_slider_110_1_wrapper" class="rev_slider_wrapper fullscreen-container" data-alias="rotating-words82"
     style="background-color:#e5e5e5;padding:0px;">
  <!-- START REVOLUTION SLIDER 5.0.7 fullscreen mode -->
  <div id="rev_slider_110_1" class="rev_slider fullscreenbanner" style="display:none;" data-version="5.0.7">
    <ul>

      <!-- SLIDE  -->
      <li data-index="rs-333" data-transition="fade" data-slotamount="default" data-easein="Power3.easeInOut"
          data-easeout="Power3.easeInOut" data-masterspeed="1500" data-rotate="0" data-saveperformance="off"
          data-title="Intro" data-description="">
        <!-- MAIN IMAGE -->
        <img src="static/picture/rs2.jpg" alt="" data-bgposition="center center" data-bgfit="cover"
             data-bgrepeat="no-repeat" data-bgparallax="10" class="rev-slidebg" data-no-retina="">
        <!-- LAYERS -->

        <!-- BACKGROUND VIDEO LAYER -->
        <div class="rs-background-video-layer" data-forcerewind="on" data-volume="mute" data-videowidth="100%"
             data-videoheight="100%" data-videomp4="videos/restaurant1.mp4" data-videopreload="preload"
             data-videoloop="loopandnoslidestop" data-forcecover="1" data-aspectratio="16:9"
             data-autoplay="true" data-autoplayonlyfirsttime="false" data-nextslideatend="true"></div>

        <!-- LAYER NR. 1 -->
        <div class="tp-caption tp-shape tp-shapewrapper   rs-parallaxlevel-0" id="slide-333-layer-10"
             data-x="['center','center','center','center']" data-hoffset="['0','0','0','0']"
             data-y="['middle','middle','middle','middle']" data-voffset="['0','0','0','0']" data-width="full"
             data-height="full" data-whitespace="nowrap" data-transform_idle="o:1;"
             data-transform_in="opacity:0;s:1500;e:Power3.easeInOut;" data-transform_out="s:300;s:300;"
             data-start="0" data-basealign="slide" data-responsive_offset="on" data-responsive="off"
             style="z-index: 5;background-color:rgba(41, 46, 49, 0.9);border-color:rgba(0, 0, 0, 0.50);">
        </div>

        <!-- LAYER NR. 2 -->
        <div class="tp-caption RotatingWords-TitleWhite   tp-resizeme  toblur rs-parallaxlevel-0"
             id="slide-333-layer-1" data-x="['center','center','center','center']"
             data-hoffset="['0','0','0','0']" data-y="['middle','middle','middle','middle']"
             data-voffset="['-50','-50','-152','-152']" data-width="none" data-height="none"
             data-whitespace="nowrap" data-transform_idle="o:1;"
             data-transform_in="x:-50px;opacity:0;s:1500;e:Power3.easeInOut;" data-transform_out="s:300;s:300;"
             data-start="750" data-splitin="none" data-splitout="none" data-responsive_offset="on"
             style="z-index: 6; white-space: nowrap;">WE LOVE <span style="color:#F2B410;">OUR CLIENTS</span>
        </div>

        <!-- LAYER NR. 3 -->
        <div class="tp-caption RotatingWords-Button rev-btn  rs-parallaxlevel-0" id="slide-333-layer-7"
             data-x="['center','center','center','center']" data-hoffset="['0','0','0','0']"
             data-y="['middle','middle','middle','middle']" data-voffset="['57','27','20','20']"
             data-width="none" data-height="none" data-whitespace="nowrap" data-transform_idle="o:1;"
             data-transform_hover="o:1;rX:0;rY:0;rZ:0;z:0;s:300;e:Power1.easeInOut;"
             data-style_hover="c:rgba(255, 255, 255, 1.00);bc:rgba(255, 255, 255, 1.00);cursor:pointer;"
             data-transform_in="y:100px;sX:1;sY:1;opacity:0;s:2000;e:Power3.easeInOut;"
             data-transform_out="y:50px;opacity:0;s:1000;e:Power2.easeInOut;s:1000;e:Power2.easeInOut;"
             data-start="750" data-splitin="none" data-splitout="none"
             data-actions='[{"event":"click","action":"scrollbelow","offset":"-76px"}]'
             data-responsive_offset="on" data-responsive="off"
             style="z-index: 11; white-space: nowrap;outline:none;box-shadow:none;box-sizing:border-box;-moz-box-sizing:border-box;-webkit-box-sizing:border-box;">
          Discover History
        </div>

      </li>
    </ul>
    <div class="tp-static-layers"></div>
    <div class="tp-bannertimer tp-bottom" style="visibility: hidden !important;"></div>
  </div>
</div>
<!-- end revolution slider -->

<!--begin section-white-->
<section class="section-white">

  <!--begin container-->
  <div class="container">

    <!--begin row-->
    <div class="row">

      <!--begin col-md-6-->
      <div class="col-md-6 text-center padding-top-50 padding-bottom-50 wow slideInLeft">

        <span class="comic-text">Relaxing</span>

        <h2 class="section-title">Atmosphere</h2>

        <p>Curabitur quas nets lacus ets nulat iaculis loremis etis nisle varius vitae seditum fugiatum ligula
          aliquam qui sequi. Lorem ipsum dolor sit amet, consectetur adipiscing elit rutrum eleif arcu sit
          aspernatur nets fugit, sed quia.</p>

        <a href="gallery.html" class="btn btn-lg btn-yellow">SEE GALLERY</a>

      </div>
      <!--end col-md-6-->

      <!--begin col-md-6-->
      <div class="col-md-6 wow slideInRight">

        <!--begin carousel1-->
        <div id="myCarousel1" class="carousel carousel1 slide" data-interval="true">

          <!--begin carousel-inner-->
          <div class="carousel-inner">

            <!--begin carousel item-->
            <div class="item active">

              <!--begin image-wrapper-->
              <div class="image-wrapper">
                <img src="static/picture/food61.jpg" alt="picture" class="width-100">
              </div>
              <!--end image-wrapper-->

            </div>
            <!--end carousel item-->

            <!--begin carousel item-->
            <div class="item">

              <!--begin image-wrapper-->
              <div class="image-wrapper">
                <img src="static/picture/food7.jpg" alt="picture" class="width-100">
              </div>
              <!--end image-wrapper-->

            </div>
            <!--end carousel item-->

          </div>
          <!--end carousel-inner-->

          <!-- begin carousel-indicators -->
          <ol class="carousel-indicators">
            <li data-target="#myCarousel1" data-slide-to="0" class="active"></li>
            <li data-target="#myCarousel1" data-slide-to="1"></li>
          </ol>
          <!-- end carousel-indicators -->

        </div>
        <!--end carousel1-->

      </div>
      <!--end col-md-6-->

    </div>
    <!--end row-->

  </div>
  <!--end container-->

</section>
<!--end section-white-->

<!--begin footer -->
<div class="footer">

  <!--begin container -->
  <div class="container">

    <!--begin row -->
    <div class="row footer-top">

      <!--begin col-md-3 -->
      <div class="col-md-3 padding-bottom-50">

        <h4>ABOUT US</h4>

        <p>Quis autem velis et reprehender etims quiste voluptate velit esse quam nihil etsa illum sedit
          consequatur quias.</p>

        <a href="about.html" class="btn btn-lg btn-yellow-x-small scrool">OUR STORY</a>

      </div>
      <!--end col-md-3 -->

      <!--begin col-md-3 -->
      <div class="col-md-3 padding-bottom-50">

        <h4>LATEST RECIPES</h4>

        <ul class="footer-list">

          <li class="first"><a href="#" target="blank">Cheddar Cheese Cauliflower Tots</a></li>

          <li><a href="#" target="blank">Garlic Chicken &amp; White Wine Sauce</a></li>

          <li><a href="#" target="blank">Spinach Mozzarella Grilled Cheese</a></li>

          <li><a href="#" target="blank">Mini Chicken Roasted Cups</a></li>

        </ul>

      </div>
      <!--end col-md-3 -->

      <!--begin col-md-3 -->
      <div class="col-md-3 padding-bottom-50">

        <h4>FEATURED PLATES</h4>

        <ul class="footer-gallery">

          <li class="popup-gallery">
            <a class="popup2" href="static/file/instagram1-large.jpg">
              <img src="static/picture/instagram1.jpg" alt="instagram">
            </a>
          </li>

          <li class="popup-gallery">
            <a class="popup2" href="static/file/instagram6-large.jpg">
              <img src="static/picture/instagram6.jpg" alt="instagram">
            </a>
          </li>

          <li class="popup-gallery">
            <a class="popup2" href="static/file/instagram2-large.jpg">
              <img src="static/picture/instagram2.jpg" alt="instagram">
            </a>
          </li>

          <li class="popup-gallery">
            <a class="popup2" href="static/file/instagram4-large.jpg">
              <img src="static/picture/instagram4.jpg" alt="instagram">
            </a>
          </li>

          <li class="popup-gallery">
            <a class="popup2" href="static/file/instagram5-large.jpg">
              <img src="static/picture/instagram5.jpg" alt="instagram">
            </a>
          </li>

          <li class="popup-gallery">
            <a class="popup2" href="static/file/instagram3-large.jpg">
              <img src="static/picture/instagram3.jpg" alt="instagram">
            </a>
          </li>

        </ul>

      </div>
      <!--end col-md-3 -->

      <!--begin col-md-3 -->
      <div class="col-md-3 padding-bottom-50">

        <h4>CONTACT DETAILS</h4>

        <p>Quis autem velis eti reprehender etimes quiste volupta velit esse quam nihil.</p>

        <p class="contact_info"><i class="fa fa-map-marker"></i> Oxford Street, London, UK, N1 1ED</p>

        <p class="contact_info"><i class="fa fa-phone"></i> +44 987 654 321 / +44 123 456 789</p>

        <p class="contact_info"><i class="fa fa-envelope-square"></i> <a href="mailto:contact@restaurant.com">contact@restaurant.com</a>
        </p>

      </div>
      <!--end col-md-3 -->

    </div>
    <!--end row -->

    <!--begin row -->
    <div class="row">

      <!--begin footer-bottom -->
      <div class="footer-bottom">

        <!--begin col-md-5 -->
        <div class="col-md-5">

          <!--begin copyright -->
          <div class="copyright ">
            <p>Copyright &copy; 2022.Company name All rights reserved.<a target="_blank"
                                                                         href="https://sc.chinaz.com/moban/">&#x7F51;&#x9875;&#x6A21;&#x677F;</a>
            </p>
          </div>
          <!--end copyright -->

        </div>
        <!--end col-md-5 -->

        <!--begin col-md-2 -->
        <div class="col-md-2 text-center">

          <a href="#hero-section" class="scrool top-scroll"><i class="fa fa-angle-double-up"></i></a>

        </div>
        <!--end col-md-2 -->

        <!--begin col-md-5 -->
        <div class="col-md-5">

          <!--begin footer_social -->
          <ul class="footer_social">
            <li>
              Follow Us:
            </li>
            <li>
              <a href="#">
                <i class="fa fa-twitter"></i>
              </a>
            </li>
            <li>
              <a href="#">
                <i class="fa fa-pinterest"></i>
              </a>
            </li>
            <li>
              <a href="#">
                <i class="fa fa-facebook"></i>
              </a>
            </li>
            <li>
              <a href="#">
                <i class="fa fa-instagram"></i>
              </a>
            </li>
            <li>
              <a href="#">
                <i class="fa fa-youtube"></i>
              </a>
            </li>
          </ul>
          <!--end footer_social -->

        </div>
        <!--end col-md-5 -->

      </div>
      <!--end footer-bottom -->

    </div>
    <!--end row -->

  </div>
  <!--end container -->

</div>
<!--end footer -->


<!-- Load JS here for greater good =============================-->
<script src="static/js/jquery-1.11.3.min.js"></script>
<script src="static/js/axios.min.js"></script>
<script src="static/js/bootstrap.min.js"></script>
<script src="static/js/bootstrap-select.js"></script>
<script src="static/js/bootstrap-switch.js"></script>
<script src="static/js/jquery.magnific-popup.min.js"></script>
<script src="static/js/jquery.nav.js"></script>
<script src="static/js/jquery.scrollTo-min.js"></script>
<script src="static/js/SmoothScroll.js"></script>
<script src="static/js/wow.js"></script>

<!-- RS5.0 Core JS Files -->
<script type="text/javascript" src="static/js/jquery.themepunch.tools.min.js"></script>
<script type="text/javascript" src="static/js/jquery.themepunch.revolution.min.js"></script>

<script type="text/javascript" src="static/js/revolution.extension.video.min.js"></script>
<script type="text/javascript" src="static/js/revolution.extension.slideanims.min.js"></script>
<script type="text/javascript" src="static/js/revolution.extension.actions.min.js"></script>
<script type="text/javascript" src="static/js/revolution.extension.layeranimation.min.js"></script>
<script type="text/javascript" src="static/js/revolution.extension.parallax.min.js"></script>

<!-- begin custom script-->
<script src="static/js/custom.js"></script>
<script src="static/js/plugins.js"></script>

</body>
</html>
