//
//  ViewModel.swift
//  StudentRecordNoCombine
//
//  Created by Abdullah Alnutayfi on 17/07/2021.
//

import Foundation
import SwiftUI
class DataStoreViewModel: ObservableObject{
    init() {
        loadStudents()
        for student in students{
            emailes.append(student.email)
        }
        print(emailes)
        print(FileManager.docDirURL.path)
    }
    @Published var emailes = [String]()
    @Published var students = [Student]()
    @Published var studentError : ErrorType? = nil
    
    func addStudent(student: Student){
        students.append(student)
        save()
    }
    func updateStudent(student: Student){
        guard let index = students.firstIndex(where: { $0.id == student.id }) else{return}
        students[index] = student
        save()
    }
    func deleteStudent(indexSet : IndexSet){
        students.remove(atOffsets:  indexSet)
        save()
    }
    func save(){
        print("Saved successfully")
       // students.append(student)
        let encoder = JSONEncoder()
        do{
            let data = try encoder.encode(students)
            let jsonString = String(decoding: data, as: UTF8.self)
            FileManager().saveDocument(content: jsonString, docName: fileName) { error in
                guard let error = error else{return}
                studentError = ErrorType(error: error)
              
            }
        }catch{
            studentError = ErrorType(error: .encodingError)
        }
    }
    func loadStudents(){
      //  students = Student.sampel
        FileManager().readDocument(docName: fileName) { result in
            switch result{
            case .success(let data):
                let decoder = JSONDecoder()
                do{
                    students = try decoder.decode([Student].self, from: data)
            
                }catch{
                    studentError = ErrorType(error: .decodingError)
                }
            case .failure(let error):
                studentError = ErrorType(error: error)
            }
        }
        
    }
}
