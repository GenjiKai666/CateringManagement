package cn.edu.usst.cateringManagement;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

//define a class as a rest controller
@RestController
//annotation used to replace System.out.println to print out log
@Slf4j
//annotation used to define this controller's url
@RequestMapping("/order")
public class OrderController {

    //demo for receiving get request
    //annotation used to define this method's url
    @GetMapping("/get/{id}")
    //hence the url for this method is http://localhost:8080/order/get
    public String get(@PathVariable("id") String id, @RequestParam("id2") String id2) {
        //@PathVariable's key should be exactly the same as the url eg. {id}
        //@RequestParam is in the form of url?id2=
        return "helloworld";
    }

    //demo for receiving post request
    @PostMapping("/post")
    public String post(@RequestBody String id) {
        //@RequestBody is used to receive params in post payload which can be
        //both in the form of json or multipart-form
        return "helloworld";
    }
}

