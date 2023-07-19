package br.csi.Parkingcontrol.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.UUID;

import org.hibernate.service.spi.ServiceException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
//import org.springframework.web.multipart.MultipartFile;

import br.csi.Parkingcontrol.repository.UserRepository;
import br.csi.Parkingcontrol.model.UserModel;
//import site.my.planet.util.ImageUtil;
@Service
public class UserService {

    private UserRepository userRepository;


    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public UserModel getUser(UUID id) {
        UserModel user = new UserModel();
        user = this.userRepository.findById(id).get();

        return user;
    }

    public ArrayList<UserModel> getUsers() {
        return (ArrayList<UserModel>) this.userRepository.findAll();
    }

    public UserModel save(UserModel user) {
        user.setSenha(
                new BCryptPasswordEncoder().encode(user.getSenha()));       

        return this.userRepository.save(user);
    }

    public void delete(UUID id) {
        this.userRepository.deleteById(id);
    } 

    public void update(UUID id, UserModel user) {
        UserModel userUpdate = new UserModel();
        userUpdate = this.userRepository.getReferenceById(id);
        userUpdate.setUsername(user.getUsername());

        userUpdate.setSenha(new BCryptPasswordEncoder().encode(user.getSenha()));
        this.userRepository.flush();
    }
    
}
