package br.csi.Parkingcontrol.repository;

import java.util.ArrayList;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import br.csi.Parkingcontrol.model.ReservaModel;
import br.csi.Parkingcontrol.model.VagaModel;

@Repository
public interface ReservaRepository extends JpaRepository<ReservaModel, UUID>{

    @Query(value = "SELECT * FROM tb_reserva r, tb_vaga v WHERE r.id_user = :id and r.id_vaga = v.id_vaga", nativeQuery = true)
    public ArrayList<ReservaModel> getReservasDoUsuario(@Param("id") UUID id);

    @Query("SELECT r FROM ReservaModel r WHERE r.vaga = :vaga")
    ArrayList<ReservaModel> findByVaga(@Param("vaga") VagaModel vaga);
    
    @Modifying
    @Query(value ="UPDATE tb_vaga SET reservado_ou_nao = false WHERE id_vaga = :idVaga", nativeQuery = true)
    void  updateReservatoFalse(@Param("idVaga") UUID idVaga);
}
