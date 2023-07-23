import { StyleSheet, Text, View } from "react-native";
import { Dimensions } from "react-native";

const vh = Dimensions.get("window").height;

export default function HomePage({ navigation }) {
  return (
    <View style={styles.container}>
      <Text style={styles.h1}>Home</Text>
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
    fontSize: 50,
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
});
