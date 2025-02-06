
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import 'dart:ui';

class CustomNetworkImageMakerSecreen extends StatefulWidget {
  const CustomNetworkImageMakerSecreen({super.key});

  @override
  State<CustomNetworkImageMakerSecreen> createState() => _CustomNetworkImageMakerSecreenState();
}

class _CustomNetworkImageMakerSecreenState extends State<CustomNetworkImageMakerSecreen> {

  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(29.3544, 71.6911),
      zoom: 14
  );

  final List<Marker> _markers = <Marker>[];

  final List<LatLng> _latlang = [
    LatLng(29.3544, 71.6911),
    LatLng(29.4565, 71.9194),
    LatLng(29.4133, 71.8460)
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  // add MARKER
  loadData()async {
    for(int i = 0; i < _latlang.length; i++){
      Uint8List? image = await loadNetWorkImage("data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxISEhUQExIWFRUVFRcVFRUVFRcVFhcVFRYXGBUVFRUYHSggGBolHRUVITEhJSkrLi4uFx8zODMtNygtLisBCgoKDg0OGhAQGy0lICUtLysrLS0tKystNS8tLTcrLjAtMC0tLS0rKy8tLS0tLi0tLS03LS0tLS0tKy0tLS0rLf/AABEIALsBDgMBIgACEQEDEQH/xAAcAAADAAMBAQEAAAAAAAAAAAACAwQAAQUGBwj/xABBEAABAgQDBgQCBwcDBAMAAAABAAIDESExBBJRBRNBYXGBFCIykQahUpKxwdHh8AcjQmJygqIzU7IVQ3PSFhfx/8QAGgEBAAIDAQAAAAAAAAAAAAAAAAEEAgMFBv/EAC8RAQACAgECBAMHBQEAAAAAAAABAgMRBBIhBRMxUUFh0RQiMnGBkcEzobHh8Ab/2gAMAwEAAhEDEQA/APuKnxN+y14g8kTRnqfkgVCuFYkmFKuiDxB5IBjeoosNft+CMQ81dVpzclR0qgeoSE3xB5I9wNSgzDWKZEseiS45KDjqsEYmmtECZKqB6R+uKHw41KExMvl0QHiLd1NJOa/NQ9aIvDjUoGtskYngtb8jRE3z34aIFQ7jqrEkwQKztX2QeIPJBqPdZh7o2szVKxzMtQgeon3PVM8QeSMQQazNaoNYXj2+9NfY9Ep3ktx15IRGJpqgVJU4ey14calC5+Wg+aBkf0qWSc2JmoUXhxqUDIdh0CVieCExiKaU9kTTnvw0QJaKq1J3AvMoPEHkg1ib9kpUBmap6LfhxqUCd0dE6CcorROU+JuEBveCCAapG6OiyFcKxAqG8ASN1qMcwkKpUb1FFhr9kAbp2ip3o1RqEoHRvNaqFjCDMhHhbFNiWPRBrejVIiNJMxUJSrgekfrigVCEjM0Tt6NUOJt3UqBhhnRMg+Wc6Kba+2sPhYe8jxWw22E6lxlZrRVxpwXz7a37V2TlAwxcODorss/7WzPzWu+WlPxSs4OHnz/067+fw/d9NdEBBE1PunaL5J/9m464gQfqRP8A3XTwH7W3TlHwo5mE/wCeV/4rXHKxT8Vq3g/LrG+nf5TD6dCcAJGhWRXAiQquNsj4hw2MBdAiBxHqYQWvb1Yay5ii6uHut8TExuHOvS1J6bRqQ7p2iobEEpTTFE+56lSxNjeaUqoGwzOckeF49k59j0Qa3o1SYrSTMVCSqsPZAuE0gzNAnb0arWI9JUiBjmEkmSOD5ZzonQ7DoErFcEBmINVOIR0QturkCYTpCRoj3o1SMTfslID3rtU6EMwrVB4c8kTTkoeOiAnsAEwKpG9dqnGKDTVB4c8kDIbARM3QxRlExRbEQNoeC052eg61QK3rtVTuhok+HPJHvxzQDFOW1ELIhJkSicM9Rw1WhCIrogdum6JER5BkLJniBoULoZd5hxQahOzGRquN8Z/EMLAQN4QHRHTbCZOWZ2p/lFz+a7TWZanpRfEfj7bG/wAbFiGrYDjAgtNszD+8ef7veQ0WnPk8um1/w7ifac0Vn0jvLjY/ExIzziMXEc576hvGXAAWht0CR48t/wBNrWdBM/WKlc8kkmpNyVpoJIABJNAACSToAKlcebTMvbVrWldR2iFP/UIv+45F/wBReaPDXj+Zo+0K+F8IbRc0OGCiyNa5Gn6rnAj2XIxOHiQnGHFhvhvH8L2lp9jccwpml6xuYYUz4bzqtomfzWYZ0niLh3uhRW1aA7zf2O4/0m6+v/AfxaMbCLHgNxMIDeAUDhbeNHao4HqF8Qmu18PbXdAxELEtuxwbGH+5CeQ1xPMX9it3HzTS2vgo+J8KufFMxH3o9Po++b06qhsMEWSRBnUESNkwRgKVpRdd4tqN5ZSpNLbEJMpo3ee3DXmtCCRXRA7dN0SYriDIUR+IGhQuZmqPmg1DcSZGydum6JTYeWpReIGhQKdEIMpo4PmvVaMEmtK190TfJfjogMwxokCKdU3fi1UHhzyQHDbMTNUe6boltdloetFvxA0KBynxVwkqjDW7oEwrhWIItio0BxvUUWGv2T4PpCDE27oHKErSuCBOFsU2LY9EnE3CXDuOqAFXA9I/XFMUkf1H9cED43DqvzTj4maI8/zvn1LiXHuSV+kMNfsvzZihKI8aPeD1zGaoc78MPQ/+f/Fk/KP5Kc6QmeFV9z/Z/wDCDMFCEV7Z4mI0F7jUsBH+kzQDjxJnyl8Rwr2iIwv9Aewv/pDgXfKa/TTXrHg0id2lt8ezXrFMcek72Irj/EmxIOMhGDGbMXa7+NjpUcw8Cuu5ymjvXQmIl5utprO49X5x2pgH4eNEgRPXDcWkix0cORBB7qZr5V4SIPMEScPaa9L+0uIDtCLLgyGDL6QYJ/IheViWPQriZKxW8xD3nGyzkw1vb1mIfpvYxJw8Em+6ZP6oQvuepUuyv9CD/wCKH/wC6zLDou3Ho8Hb1knC8eyc+x6JWK4d/uSWXHVSxCqsPZNUuIugdiPSpEyB6lWgGHYdAlYrgkxLnqU3C8UCW3Vy06yiCBmJv2SlVh7d01Anw41K045KDimbwapUYTtVBgi5qaovDjUpbGEEEhP3g1QKMTL5dFgdnoetEMRpJmBRbgiRmaUQH4calB4g6J29GqmMM6IGtGep4LDBArpVZBOW9Eb3gggFArxB0RCHm82qVuzonwnACRoUAluWoXwD442eYGOjs4PeYrf6YpLvkSR2X6AimYkKr5z+13YhdBh4xorCOSJT/tvIyuP9Lv8AkVW5WPqx9vg6vg/IjFyIifS3b6PlBX1X4B+O4bobcLinhkRgDWRHmTXtFGhzjZ4tW6+UTWiudiy2xzuHpuZxMfJp02/SX6W8RMTBmNRUe68t8U/GcDCtIDhEjfwwmkGRNjEI9LfmvibXkDKHEDQEgc6IAFZtzJmO0OTi8DrW2723HtrR2KxDoj3RHuzPe4uc7Um6bsrBGPHhQAJmLEaymjnAOPYTPZSL337Idm5sQ/FuAywRkZMynEeK5eEw3/mFXxUm94h0+VmjBgtaPhHb+H2JmFaAGiwAA6ASH2LN+RTRE3ENNJyOhoe2vZKdDMzRdl4cbfPfhpzRbgCs7VQwfLOdEx0QSugV4g6IgzNVK3Z0ToTpCRog0YeWoQ+IOiZFcCJCpSN2dEDRBBrO9fdYfJbjqjY8AAT4II3mtVAO/Joj8ONUkQzoqd4NUCnPy0HVa8QdAsjCZmKoN2dEAKnDW7o9y3RKinLaiBsWxUaax5JkbJrmNAmZAakyQFB9IQYm3dJdHP8ACCRwpIe5ugixSBN7mtHP8TL7EGFUHEt4ebpX52C4mI2vAbacQ+493U9gufiNvRXekBnTzH3P4LOMdpYzeIejxUY+ogAc3fkoztJornhjq6f2FeXjRXPM3OLjzJKQ6HotkYPeWHm/J61+3mf7rP7WOP4qeJt2HfeOPRkvtC8ssU+RHujzZejO32CxiH2Clxu2IcVjoT4bnMe0tcC81a4SK4yxT5NUebaO8PmW1cC6BFdCPCrSf4mH0u9h7gqMr6D8TbI8RCm0fvWVZ/MOMOfO45jmvnp/X4FcHlcecV9fD4PceG86OVh3P4o7T9f1YtErRK0StEQvTY/CYZ8WIyFDE3vcGtGpP2Bfe9gbF8Lh4eHZJ2RvmILfO81e6U+Jn2kvF/sz+HN03xsZpD3giCC0+SGRWJyc6w45eq93vQeE/ZdDj4+mNy8x4ry/Nv5dfSP8qQx4EsploRmHtw7JsPFFuo5EOLfe4+ag3p4U6E/ctPxTgJmI4AfzGSs7iO7k6260XEAgTpzu3634yW2XHULy2I2k4nykj+YgZj8rdU/A7ReTLLPVzfJLrwKq15+K2Tohtnj3ivVL16lxF1CzaLuJ+tT/ACEwq4WJYRN1OZt7iiubaBQPUq0h0pZm+4ql712qkDEuepTcLxRthggEhDF8tqTQOdZRBGIp1VG6bogHD27pqmiuymQoh3rtUDfEDmtOGeo4aqdU4W3dAAhFtTKiDGBsRhYZixBFwQZg+6pi2KjQT4TEmZgxKRAL2zj6TefL9DgbZwD4bsxJe0mjiSSDo7RW7egxGgRGicjMHSWh4KjY+1GYhmR0s0pOaeOsxr/+jlNL9MotXcPNLF0dq7LMI5m1hnjxbyP4rnsYTYE9BNXYtExuFaYmJ00sTfDP+g76pQ7l/wBB31SnVHuakp7QlmGdD7FdaAd2KAZzc3y6ALH4h5u4+6qX5dazqIZxT3cYuGoRMYTb34LqwsPm0nPiAfnLkifDLeHefRab86d9NK7lsrhie8yRhoAb5pTN5mgHOXtdeH+PthSJxkJvlP8ArNEzJ5Mt6NAePOvFe7J4zrqlx8aJEPAcDMEOaDQ3FORKr2x3yd8k/Rd4vInj3i1P1+b4iSvR/Bnw94l+9iD9xDNbjeP4MEuAuT24rWN+HmeKDWOLYDiXEgEvhjjDE7msgdL2r9F2duWQ2woUmsYJNa4EHqTxJ4nitWLBO/vOxzPE6+XrFPef7f7XNeQZgkdDL5WTm4t38WV39QE/cSSCDKfAXIIIUUbFk0Z9bj206rfmz0xRu0uFTHa89nSjbShtplcHaNdmHedQoIuIL6uM5WAoB0HEqWDBc4yaJm5mbcyV0sPgA2pMzr+Gi5s+dzJ9q/8AfutR0YfnJkDZjz5nAhspyFz1lb7VawAeUCUuFvklwDlP5rptjmV5jmAQuhg4+PDGq/uq5Mtrz3SCGdEbIRFjLp+FlRmFsl/okg9hZGWMBqa6ETAOjsqsNYIVszpy+kPKSeguqQZXM28Hf+0vtU5Y5xnMOPIj5A2WmuLNRqCDI/rVSOoIwFK0otO89uGqihvB9PdmnNp/XZV4NwMyP11WSGbg3oj8QOaa6yhCB7mZqjpVa8OeSZh7d01BinxPBZ4g6LYGeqBUI1CsSDCy10WvEHRAuOKkGy8/tD4fdn32GIbEFS2wcNJix0PBelELN5tVhbkqOijQ4uE2q1zS2M0sd6XNcKf3cB9miViMM+8N028ADL2lQro7TwbI4k4ScPS9pLXt6EfYvK42DjMI4kfvWatkx8uYlkeeo7rG0bjUil7nihLhyJKDOdT7oMF8VwIp3cQSdbLEAhvnyDjld2cuicLDf6HSP0XX9jX7VpnHPwljNZc9YqIuDe2478PdD4Z2i02+76nTJ+Bb95+78U+GBL1SnUzFJmvqH3oITCGmlZS+X5lNhw5/r7lGCYnJad+0N2tViC34Sdcs+bSD9ikfg+/Kx9l02wRf8k4xSBUiX8wBEuqusXB8GOLR3QxsjL34AX/JVbQxYdSG3KfpTMj0aftXIZCc52WUybzPzJK5ufnxvoxd5WcfH7dV+0NRX5jMyHIW/NUYfAk1dQacT+Crg4DJVwJOspgdJfaU8LHDwptPXmnc+yb54iOmjbA0CWQAciWn75rcm6kdRMfJCtZl04iIjUKoxDnYg9DX2Kdhy4GRBA4k2HPmlMhE3aZdJE9zYI3zb6nthjgJ/Kt1IvEQfwH+7iRy0CAafJStx8No8836eUMr1Mp+6TG21FNIGHeZ/RZSvEvfJvyKIdMQHGpEhq6iW/HQ4YmYpd/SfL9YmQ91wn7P2liDUw4I5nev9iMjewVOF+Ca5o0Z0Q/zEmXQWHZSKIe1y8ygsaJ/xeonnM/mupg8O9oL3vLi72Ev1oFrC7PhwqATlryV7BmpaWimIQS01VyTuAOKHxB0UjWIv2Spp4Zmr2W/DjVAndnQp0EyFaJynxNwgZEeCCAVPuzoVkK4ViBUNwAkStRjMSFapUb1FFhr9kAbs6J0UMcJGScoSg85t/4VhxQaAheMi4DFYWkGIcg/7bxnZ2BqOxC+u4YUKj2hstrxZY6Tt852f8eOhkMxENzNSAYkPr9No7novbbKiwcRDESG64n5TSVpidx7EcV57bXwyHA+XVeYwL4+z4mZmYwpzczTVzOE5XFj7LG1Yt2mNpfTspBlY9Bb7wsJ1E+l0Oy9pQsXDD2OE5TBHzIB4ag1HsVPtLEOhnKBUj1EU/t1VTkYcFKTeY1r2Z06rTqDMRiGsFzPg25P4dSuVicS5/qoNBbvqltaXHiSdfvK6eGwAbImruAlMdhx6rl1+0cmJrSZ6fmuax4e895S4XBF9TQf5HoOHUroHDNDcoEtNfzVYgEib5NA48ZdbBQbQ29h8OJzGkyTX+mmZ3YS5rp8PjRir3rqff1VcuWbyEYaI0yALe8vl+SxxAo97SeQGb5fgvK4/wCJcViDlhQvL9KIJD+2E0/8iVrDbFxkakSM8A3bD/dN9mSPuVdaXocRjYEP1e8RwYP8iD8lD/8AJmGkFpf/AOOG53+bsrftVeyvgWE0hzmzOrqu9zVd/D7Phw6NaKclOh5yAzGx7Q8g1iPn/hDkPmunhfhs3ixXnUQwITfdvmPuvQYXj2+9NfY9FOjaTC4KBD9DGg63d9Y1TIoJMxUJKqw9lKCoTSDM0T94NQtYj0qRAxzCSTLijgUnOidDsOgSsVwQMMQaqbdnRC26uQJhGQkaVR7wahIxN+yUgZvna/YmQhmEzVD4c8kTTkoeOiAnwwBMCqTvna/Ymuig0HFB4c8kDGMBEzdDFGUTFOC22IG0PBac7NQdaoF752v2J+6boleHPJHvxzQDFOW1ELYhJkTdE8Z6jhqtCERWlKoGOgNNCFxdqbEhxJiS7XiBzQOhl3mFimh83jbJj4GJvoMy0mb2Ck/5mng6XvYr1uzdoQsZClxrSxBFyBwI4j7pFdowpeoAjS64mL2EzPvoBMJ9yP4HStMcDzHzWM1iY1KYlXAwwhCZcGt41FeZLuK5+O+IYUHyME3aSm49GDzHvIJ52DFiHNFjHoyh+uRT+0BWYLY8CB6YY6+o9ybqK1iI1EagmdzuXlIjsbijQGG3gXAFwHJssrD7nmqcD8INBzxCXO4ucS5x7lex3glICU6IfDnkstG0mC2PCaJ5Va+GGibRJba/LQ/Jac/NQfNSgvfO1+xPbCBrJK8OeSMRgKVog1F8spUmltik0mjf57cNea0IJFaUQN3LdEqI4tMhZM8QOaBzM1R80Goby4yNk3ct0S2sLan5I/EDmgU6IQZA2oihea9ZLRgk1pWvuiZ5L8dEBmENEgRnapu/FqoPDnkgOG3NU1RbluiBrstD1oi8QOaBqnxNwkzVGGt3QJg3CsQRbFSz5oNxvUUeGv2ToNghxFu6BqhKyfNWgIE4WxTYtj0ScRcJcO46oAVcD0j9cUclNG9R/XBA3E27qVOw9+yokgxtkjFcEpxTsNxQJh3HUK1DEFD0KknzQFiPUt4e6dAstR7IGqJ9z1K1PmrGCg6IE4Xj2+9OfY9ErE8O6Uw1HVACqw9kySnj3QNxHpUibAuqZINQ7DoErFcEp5qepTcNxQIbdXLTgo5oDxN+yUqsPbumSQJ8PzWi7JS/FUKbFX7INiLmpqi8ONUmF6grEE5i5fLosDs9LcUuN6ijw1+34IC8ONVrxB0VChKB4GetpLDBlWdlvDWKZEseiBPiDotiHm82qnCrgekfrigAsy1vwWvEHRHibKVBRuJ1mtHyc5p7bJGK4IM306SvRF4capEO46hWoJzEy+VYH5qII/qW8PdAfhxqtb+VJWoqFC+5QPHn5S+9ZuJVnaqzC8e33pr7HogT4g6LYZmqp1Vh7IBMPL5lrxB0TI/pUgQUCDOs7191hGTnNNh2HQJWK4INb+dJLfhxqkNurkE5dkpdZ4g6LWIv2SQg/9k=");
      final ui.Codec markerImageCodec = await ui.instantiateImageCodec(
        image.buffer.asUint8List(),
        targetHeight: 100,
        targetWidth: 100,
      );

      final ui.FrameInfo frameInfo = await markerImageCodec.getNextFrame();
      final ByteData? byteData = await frameInfo.image.toByteData(
        format: ui.ImageByteFormat.png
      );
       final Uint8List resizedImageMarker = byteData!.buffer.asUint8List();
      _markers.add(
        Marker(
            markerId: MarkerId(i.toString()),
          position: _latlang[i],
          icon: BitmapDescriptor.fromBytes(resizedImageMarker),
          infoWindow: InfoWindow(
            title: 'Title of marker' +i.toString()
          )
        )
      );
      setState(() {

      });
    }
  }

  Future<Uint8List> loadNetWorkImage(String path) async{
    final completer = Completer<ImageInfo>();
    var image = NetworkImage(path);
    image.resolve(ImageConfiguration()).addListener(
        ImageStreamListener((info,_) => completer.complete(info)));
    final imageInfo = await completer.future;
    final byteData = await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GoogleMap(
              initialCameraPosition: _kGooglePlex,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            markers: Set<Marker>.of(_markers),
            onMapCreated: (GoogleMapController controller){
                _controller.complete(controller);
            },
          )
      ),
    );
  }
}
