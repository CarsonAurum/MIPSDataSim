//
//  HelpData.swift
//  DataSim
//
//  Created by Carson Rau on 5/11/23.
//

import Foundation

protocol HelpInfo {
    var action: String { get }
    var inputs: String { get }
    var outputs: String { get }
    var uses: [String] { get }
}

struct HelpData {
    static let info: [DatapathComponent: HelpInfo] = [
        .alu: HelpData.ALU(),
        .regfile: HelpData.RegFile(),
        .mux: HelpData.Mux(),
        .adder: HelpData.Adder(),
        .signExt: HelpData.SignExtension(),
        .shifter: HelpData.Shifter(),
        .pc: HelpData.ProgramCounter(),
        .instMem: HelpData.InstructionMemory(),
        .dataMem: HelpData.DataMemory()
    ]
    struct ALU: HelpInfo {
        let action: String =
            "The Arithmetic Logic Unit (or ALU) is a datapath element within the processor that"
          + "is responsible for computing logical and arithmetic operations on the data it receives."
        let inputs: String =
            "The ALU receives two inputs. These typically come from the register file, but special "
          + "instruction types, like branches, use a portion of the instruction as an input to the ALU."
        let outputs: String =
            "The ALU has two outputs, the top output is the primary output for this logic unit, and the "
          + "secondary output is an optional \"zero\" value used as a control signal for certain instructions."
        let uses: [String] = [
            "Arithmetic operations (eg. addition, subtraction, multiplication, and division) on integer operands.",
            "Logical operations (eg. and, or, xor, nand)",
            "Comparing values for equality (eg. beq)"
        ]
    }
    struct RegFile: HelpInfo {
        let action: String =
            "A Register File is a collection of short-term, quick access storage locations of 32-bits in size "
          + "that are used to store immediate data values or operands during operations. These are the fastest "
          + "kind of memory within the computer."
        let inputs: String = "The Register File receives a wide variety of connections to support a range of operations. "
          + "the top two inputs are responsible for providing register numbers from which to read data.The third input, write "
          + "register, determines which register will be written (if the control signals not modeled in this application "
          + "dictate). The final input contains the data to be written, which typically comes from the ALU or the Data Memory."
        let outputs: String = "The two outputs from the register file contain the data read from the two registers given as inputs."
        let uses: [String] = [
            "Holding operands and intermediate results during arithmetic/logical operations.",
            "Storing values fetched from memory.",
            "Supporting register-to-register data transfers."
        ]
    }
    
    
    struct Mux: HelpInfo {
        let action: String =
            "A Multiplexor (Mux) connects two outputs to a single input, allowing selection between them with a control signal"
        let inputs: String =
            "There are two inputs given to the mux, from which it can pick."
        let outputs: String = "Of the two given inputs, one is selected to be forwarded."
        let uses: [String] = [
            "Enables switching between different registers for a variety of instructions on the same datapath circuit.",
            "Dynamically allows selection of the program counter's source."
        ]
    }
    
    struct Adder: HelpInfo {
        let action: String = ""
        let inputs: String = ""
        let outputs: String = ""
        let uses: [String] = []
    }
    
    struct SignExtension: HelpInfo {
        let action: String = ""
        let inputs: String = ""
        let outputs: String = ""
        let uses: [String] = []
    }
    
    struct Shifter: HelpInfo {
        let action: String = ""
        let inputs: String = ""
        let outputs: String = ""
        let uses: [String] = []
    }
    
    struct ProgramCounter: HelpInfo {
        let action: String = ""
        let inputs: String = ""
        let outputs: String = ""
        let uses: [String] = []
    }
    
    struct InstructionMemory: HelpInfo {
        let action: String = ""
        let inputs: String = ""
        let outputs: String = ""
        let uses: [String] = []
    }
    
    struct DataMemory: HelpInfo {
        let action: String = ""
        let inputs: String = ""
        let outputs: String = ""
        let uses: [String] = []
    }
    
    static func getInfo(for kind: DatapathComponent) -> HelpInfo { info[kind]! }
}
