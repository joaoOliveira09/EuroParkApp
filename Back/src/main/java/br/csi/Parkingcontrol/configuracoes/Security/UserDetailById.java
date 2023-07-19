package br.csi.Parkingcontrol.configuracoes.Security;

import java.util.Optional;
import java.util.UUID;

import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import br.csi.Parkingcontrol.model.UserModel;
import br.csi.Parkingcontrol.repository.UserRepository;

@Service
public class UserDetailById {

  final UserRepository userRepository;

  public UserDetailById(UserRepository userRepository) {
    this.userRepository = userRepository;
  }

  public UserDetails loadUserById(UUID id) throws UsernameNotFoundException {
    Optional<UserModel> usuario = this.userRepository.findById(id);

    if (usuario == null) {
      throw new UsernameNotFoundException("Usuário ou senha incorretos");
    } else {
      UserDetails user = User.withUsername(usuario.get().getUsername())
          .password(usuario.get().getSenha()).build();
         // .authorities(usuario.get().getPermissao()).build();

      return user;
    }
  }
}