import { StyleSheet, Text, View } from "react-native";
import { Dimensions } from "react-native";

import { Button } from "../components";

import { SvgUri } from "react-native-svg";

const vh = Dimensions.get("window").height;

export default function LandingPage({ navigation }) {
  return (
    <View style={styles.container}>
      <Text style={styles.h1}>AI Puzzles</Text>
      <Text style={styles.h2}>
        Create your own puzzle within the reach of a touch
      </Text>

      <SvgUri
        width="300"
        height="300"
        style={styles.icon}
        uri="https://svgur.com/i/vbS.svg"
      />

      <Button
        title="Get started"
        onPress={() => navigation.navigate("Input")}
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
    top: vh * 0.2,
  },
  icon: {
    position: "absolute",
    zIndex: 1,
    top: vh * 0.35,
  },
});
