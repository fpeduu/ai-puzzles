import { Image, Pressable, StyleSheet, Text, View } from "react-native";
import { Dimensions } from "react-native";

import { Button } from "../components";

const vw = Dimensions.get("window").width;
const vh = Dimensions.get("window").height;

export default function LandingPage() {
  return (
    <View style={styles.container}>
      <Text style={styles.h1}>AI Puzzles</Text>
      <Text style={styles.h2}>
        Create your own puzzle within the reach of a touch
      </Text>

      <Image style={styles.logo} source={require("../assets/ai.png")} />

      <Button title="Get started" onPress={() => console.log("Start")} />
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
  logo: {
    width: vw * 0.5,
    height: vw * 0.5,
    position: "absolute",
    zIndex: 1,
    top: vh * 0.4,
  },
});
