// Factorial.swift
//
// Created by Remy Skelton
// Created on 2025-April-23
// Version 1.0
// Copyright (c) Remy Skelton. All rights reserved.
//
// This program will read an multiple lines of integers from the a input file.
// If the data is valid then it will calculate the factorial of each integer

// Import Foundation
import Foundation

// Define the InputError enum to handle errors
enum InputError: Error {
    case invalidInput
}

// Do catch block to catch any errors
do {
    // Welcome message
    print("Welcome to the factorial program!")
    print("This program reads multiple lines,", terminator: "")
    print("of integers from input.txt, and find the factorial of them", terminator: "")
    print(", and writes the result to output.txt.")

    // Initialize output string
    var outputStr = ""

    // Define the file paths
    let inputFile = "input.txt"
    let outputFile = "output.txt"

    // Open the input file for reading
    guard let input = FileHandle(forReadingAtPath: inputFile) else {
        throw InputError.invalidInput
    }

    // Read the contents of the input file
    let inputData = input.readDataToEndOfFile()

    // Convert the data to a string
    guard let inputStr = String(data: inputData, encoding: .utf8) else {
        // Throw an error if the data cannot be converted to a string
        throw InputError.invalidInput
    }

    // Split the input into lines
    let inputLines = inputStr.components(separatedBy: "\n")

    // Create position variable
    var position = 0

    // While loop to read each line
    while position < inputLines.count {

        // Split the line into integers
        let currentLine = inputLines[position]
        let currentLineArray = currentLine.components(separatedBy: " ")

        // For loop to go through array
        for currentIntAsStr in currentLineArray {
            // Convert the string to an integer
            guard let currentInt = Int(currentIntAsStr) else {
                // Write an error message to the output string
                outputStr += "Invalid: \(currentIntAsStr) is not a valid integer.\n"
                // Continue to the next iteration
                continue
            }

            // Check if the integer is negative
            if currentInt < 0 {
                // Write an error message to the output string
                outputStr += "Invalid: \(currentIntAsStr) is not a valid integer.\n"
            } else {
                // Call the factorial function
                let factorial = recFact(number: currentInt)

                // Append the result to the output string
                outputStr += "\(currentInt)! = \(factorial)\n"
            }
        }
        // Increment the position
        position += 1
    }

    // Write to output.txt
    try outputStr.write(toFile: outputFile, atomically: true, encoding: .utf8)

    // Print the that the output is written to the file
    print("Factorial written to output.txt.")

} catch {
    // Print the error message
    print("Error: \(error)")
}

// Function to to find factorial of integer using recursion
func recFact(number: Int) -> Int {
    // Base case: if the number is 0 return 1
    if number == 0 {
        // Return an 1 if the number is 0
        return 1
    } else {
        // To find the factorial of the number
        // Multiply the number by the factorial of the number - 1
        return number * recFact(number: number - 1)

    }
}
