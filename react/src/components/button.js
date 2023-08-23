import { Pressable, StyleSheet, Text } from "react-native";
import { Dimensions } from "react-native";

const vw = Dimensions.get("window").width;
const vh = Dimensions.get("window").height;

export default function Button(props) {
  const { title, onPress } = props;

  return (
    <Pressable style={styles.button} onPress={onPress}>
      <Text style={styles.buttonText}>{title}</Text>
    </Pressable>
  );
}

const styles = StyleSheet.create({
  button: {
    backgroundColor: "#F8F1FF",
    width: vw * 0.8,
    padding: 10,
    alignItems: "center",
    borderRadius: 10,
    position: "absolute",
    zIndex: 2,
    top: vh * 0.9,
  },
  buttonText: {
    color: "#343434",
    fontSize: 20,
  },
});
