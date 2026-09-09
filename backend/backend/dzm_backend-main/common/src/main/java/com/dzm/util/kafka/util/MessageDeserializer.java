package com.dzm.util.kafka.util;

import java.io.ByteArrayInputStream;
import java.io.ObjectInputStream;

public class MessageDeserializer<T> {

    public T deserialize(byte[] data) {

        try {
            ByteArrayInputStream bis = new ByteArrayInputStream(data);
            ObjectInputStream in = new ObjectInputStream(bis);
            return (T) in.readObject();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }

}

