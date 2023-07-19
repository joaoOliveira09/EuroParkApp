package br.csi.Parkingcontrol.configuracoes.Security;


import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import br.csi.Parkingcontrol.repository.UserRepository;
import br.csi.Parkingcontrol.model.UserModel;

@Service
public class UserDatailsServiceImpl implements UserDetailsService {

    final UserRepository usuarioRepository;

    public UserDatailsServiceImpl(UserRepository usuarioDao) {
        this.usuarioRepository = usuarioDao;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
       UserModel usuario = this.usuarioRepository.findByUsername(username);

        if (usuario == null) {
            throw new UsernameNotFoundException("Usuário ou senha incorretos");
        } else {
            UserDetails user = User.withUsername(usuario.getUsername())
                    .password(usuario.getSenha()).build();
                    //.authorities(usuario.getPermissao()).build();

            return user;
        }
    }

}