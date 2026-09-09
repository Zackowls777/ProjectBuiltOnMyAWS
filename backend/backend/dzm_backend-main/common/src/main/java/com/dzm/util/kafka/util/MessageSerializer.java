package com.dzm.util.kafka.util;

import java.io.ByteArrayOutputStream;
import java.io.ObjectOutputStream;

public class MessageSerializer<T> {

    public byte[] serialize(T t) {

        try {
            ByteArrayOutputStream bos = new ByteArrayOutputStream();
            ObjectOutputStream out = new ObjectOutputStream(bos);
            out.writeObject(t);
            return bos.toByteArray();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }
}
