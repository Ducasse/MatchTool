"
A RewriteRuleBrowserTests is test class for testing RewriteRuleBrowser.

Instance Variables
	tool:		<RewriteRuleBrowser>

tool
	- an instance of RewriteRuleBrowser

"
Class {
	#name : #RewriteRuleBrowserTests,
	#superclass : #TestCase,
	#instVars : [
		'tool'
	],
	#category : #'MatchTool-RewriteTool-Tests'
}

{ #category : #initialization }
RewriteRuleBrowserTests >> buildRewriteRuleBrowser [
	self tool: RewriteRuleBrowser new.
	self tool rules items: (RBTransformationRule subclasses collect: [ :each | each name ]).
	self tool buildWithSpec
]

{ #category : #tests }
RewriteRuleBrowserTests >> testClassesChanged [
	self buildRewriteRuleBrowser.
	self tool packages selectIndex: 1.
	self tool classes setSelectedIndex: 1.
	self assert: self tool methods selectedIndex equals: 0
]

{ #category : #tests }
RewriteRuleBrowserTests >> testPackagesChanged [
	self buildRewriteRuleBrowser.
	self tool packages selectIndex: 1.
	self assert: self tool packages selectedIndex ~= 0.
	self assert: self tool classes selectedIndex = 0
]

{ #category : #tests }
RewriteRuleBrowserTests >> testRulesChanged [
	self buildRewriteRuleBrowser.
	self tool rules selectedIndex: 1.
	self assert: self tool rules selectedIndex ~= 0.
	self assert: self tool rules selectedItem isNotNil.
	self assert: self tool browseButton isEnabled.
	self tool rules selectedIndex: 0.
	self assert: self tool rules selectedIndex = 1.
	self assert: self tool rules selectedItem isNotNil.
	self assert: self tool browseButton enabled
]

{ #category : #tests }
RewriteRuleBrowserTests >> testSimpleRuleUsage2 [
	| rule result |
	self buildRewriteRuleBrowser.
	rule := #MyRule2.
	result := self tool getResultOfRule: rule appliedTo: DemoRule2 asOrderedCollection.
	self assert: result rewriteRule answer
]

{ #category : #accessing }
RewriteRuleBrowserTests >> tool [
	^ tool
]

{ #category : #accessing }
RewriteRuleBrowserTests >> tool: anObject [
	tool := anObject
]
