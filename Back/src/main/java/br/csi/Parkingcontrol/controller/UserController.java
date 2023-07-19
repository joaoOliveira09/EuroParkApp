package br.csi.Parkingcontrol.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.UUID;

import br.csi.Parkingcontrol.model.UserModel;
import br.csi.Parkingcontrol.service.UserService;

import javax.validation.Valid;

@RestController
@RequestMapping("/user")
public class UserController {
 
    private UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/{id}")
    public UserModel getUser(@PathVariable("id") UUID id) {
        return this.userService.getUser(id);
    }

    @GetMapping()
    public ArrayList<UserModel> getUsers() {
        return this.userService.getUsers();
    }

    @PostMapping()
    public UserModel create(@Valid @RequestBody UserModel usuario) {
        return this.userService.save(usuario);
       
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Object>delete(@PathVariable("id") UUID id) {
        //this.userService.delete(id);
        try {
             this.userService.delete(id);
            // return ResponseEntity.ok("Usuário excluído com sucesso!");
            return new ResponseEntity<>(HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
        }
         return new ResponseEntity<>("Não é Possível Excluir Esse Usuario",
                 HttpStatus.BAD_REQUEST);
    }

    @PutMapping("/{id}")
    public void update(@PathVariable("id") UUID id, @RequestBody UserModel user) {
        this.userService.update(id, user);
    }
    
}
