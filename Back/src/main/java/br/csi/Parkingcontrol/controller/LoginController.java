package br.csi.Parkingcontrol.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.csi.Parkingcontrol.repository.UserRepository;
import br.csi.Parkingcontrol.model.UserModel;
import br.csi.Parkingcontrol.configuracoes.Security.JWTAutentication;

@RestController
@RequestMapping("/login")
public class LoginController {

    private AuthenticationManager authenticationManager;
    private UserRepository userRepository;

    public LoginController(UserRepository userRepository, AuthenticationManager authenticationManager) {
        this.userRepository = userRepository;
        this.authenticationManager = authenticationManager;
    }

    @PostMapping()
    public ResponseEntity<Object> autenticacao(@RequestBody UserModel user) {

        try {
            final Authentication authenticate = this.authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(user.getUsername(),
                            user.getSenha()));

            if (authenticate.isAuthenticated()) {
                SecurityContextHolder.getContext().setAuthentication(authenticate);

                user = this.userRepository.findByUsername(user.getUsername());

                String token = new JWTAutentication().geraToken(user);
                user.setToken(token);
                user.setSenha("");

                return new ResponseEntity<>(user, HttpStatus.OK);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ResponseEntity<>("Usuário ou senha incorretos",
                HttpStatus.BAD_REQUEST);
    }
}
