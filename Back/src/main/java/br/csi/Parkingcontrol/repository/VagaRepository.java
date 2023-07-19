package br.csi.Parkingcontrol.repository;

import java.util.UUID;

import br.csi.Parkingcontrol.model.UserModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import br.csi.Parkingcontrol.model.VagaModel;

@Repository
public interface VagaRepository extends JpaRepository<VagaModel, UUID>{

    
}
