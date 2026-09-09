package com.dzm.model;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.io.Serializable;
import java.util.UUID;

@Getter
@SuperBuilder
@NoArgsConstructor
public class Channel implements Serializable {

    @Builder.Default
    private String id = UUID.randomUUID().toString().replace("-", "");

    private String creator;

    private String cover;

    private Integer price;

    private Integer inventory;

    @Builder.Default
    private Boolean isDeleted = false;

    @Builder.Default
    private Long createdTime = System.currentTimeMillis();

    @Builder.Default
    private Long modifiedTime = System.currentTimeMillis();

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public void setCreator(String creator) {
        this.creator = creator == null ? null : creator.trim();
    }

    public void setCover(String cover) {
        this.cover = cover == null ? null : cover.trim();
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public void setInventory(Integer inventory) {
        this.inventory = inventory;
    }

    public void setIsDeleted(Boolean isDeleted) {
        this.isDeleted = isDeleted;
    }

    public void setCreatedTime(Long createdTime) {
        this.createdTime = createdTime;
    }

    public void setModifiedTime(Long modifiedTime) {
        this.modifiedTime = modifiedTime;
    }
}