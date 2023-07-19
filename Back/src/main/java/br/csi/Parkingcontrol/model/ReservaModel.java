package br.csi.Parkingcontrol.model;

import java.io.Serializable;
import java.sql.Date;
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
@Table(name = "tb_reserva")
public class ReservaModel implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id_reserva")
    private UUID id_reserva;
    @Column(name = "periodo")
    private String periodo;
    @ManyToOne
    @JoinColumn(name = "id_user")
    private UserModel user;
    @ManyToOne
    @JoinColumn(name = "id_vaga")
    private VagaModel vaga;
    
    // @OneToOne(mappedBy = "reserva", cascade = CascadeType.ALL, optional = false)
    //    // private PagamentoModel pagamento;

}
