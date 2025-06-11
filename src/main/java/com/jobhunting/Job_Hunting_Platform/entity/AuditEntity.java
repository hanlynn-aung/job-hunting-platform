package com.jobhunting.Job_Hunting_Platform.entity;

import jakarta.persistence.Column;
import jakarta.persistence.EntityListeners;
import jakarta.persistence.MappedSuperclass;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.JdbcType;
import org.hibernate.type.descriptor.jdbc.VarcharJdbcType;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.util.UUID;

@Getter
@Setter
@MappedSuperclass
@EntityListeners(AuditingEntityListener.class)
public class AuditEntity extends BaseEntity {

    @CreatedBy
    @Column(name = "created_by", updatable = false)
    @JdbcType(VarcharJdbcType.class)
    private UUID createdBy;

    @LastModifiedBy
    @Column(name = "updated_by")
    @JdbcType(VarcharJdbcType.class)
    private UUID updatedBy;

}
