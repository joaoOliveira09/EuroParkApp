package br.csi.Parkingcontrol.model;

import java.io.Serializable;
import java.util.UUID;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "tb_vaga")
public class VagaModel implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id_vaga")
    private UUID id_vaga;
    @Column(name = "numeroVaga")
    private int numeroVaga;
    @Column(name = "valorPelaVaga")
    private Float valorPelaVaga;
    @ManyToOne
    @JoinColumn(name = "id_user")
    private UserModel user;
}
