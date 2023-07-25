import { useState } from "react";
import { StyleSheet, Text, View, TextInput, Dimensions } from "react-native";
import { Button } from "../components";

const vh = Dimensions.get("window").height;
const vw = Dimensions.get("window").width;

export default function InputPage({ navigation }) {
  const [text, onChangeText] = useState("Pikachu landing in mars");

  return (
    <View style={styles.container}>
      <Text style={styles.h1}>Send your first input!</Text>
      <TextInput
        editable
        multiline
        numberOfLines={2}
        maxLength={40}
        onChangeText={(text) => onChangeText(text)}
        value={text}
        style={styles.input}
      />
      <Button
        title="Send"
        onPress={() =>
          navigation.navigate("Puzzle", {
            input: text,
          })
        }
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#343434",
    alignItems: "center",
    justifyContent: "center",
  },
  h1: {
    color: "#F8F1FF",
    fontSize: 36,
    position: "absolute",
    zIndex: 2,
    top: vh * 0.1,
  },
  h2: {
    color: "#F8F1FF",
    fontSize: 20,
    position: "absolute",
    zIndex: 2,
    top: vh * 0.3,
  },
  icon: {
    position: "absolute",
    zIndex: 1,
    top: vh * 0.4,
  },
  input: {
    position: "absolute",
    zIndex: 2,
    top: vh * 0.5,
    color: "#343434",
    paddingLeft: 5,
    height: 40,
    width: vw * 0.8,
    backgroundColor: "#F8F1FF",
    borderRadius: 10,
  },
});
