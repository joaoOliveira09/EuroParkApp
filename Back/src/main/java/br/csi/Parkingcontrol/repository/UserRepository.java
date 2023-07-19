package br.csi.Parkingcontrol.repository;

import br.csi.Parkingcontrol.model.UserModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface UserRepository extends JpaRepository<UserModel, UUID> {

    UserModel findByUsername(String username);
}
